//
// Copyright (c) 2016-2019 Vinnie Falco (vinnie dot falco at gmail dot com)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//
// Official repository: https://github.com/boostorg/beast
//

//------------------------------------------------------------------------------
//
// meant to connect to cpp/server example
// lacks a lot of ssl junk
//
//------------------------------------------------------------------------------

//[example_websocket_client

#include <boost/asio/connect.hpp>
#include <boost/asio/ip/tcp.hpp>
#include <boost/beast/core.hpp>
#include <boost/beast/websocket.hpp>
#include <chrono>
#include <cstdlib>
#include <iostream>
#include <string>

#include "helpers.hpp"
#include "nlohmann/json.hpp"
#include "ore.hpp"

// for convenience
using json = nlohmann::json;

namespace beast = boost::beast;          // from <boost/beast.hpp>
namespace http = beast::http;            // from <boost/beast/http.hpp>
namespace websocket = beast::websocket;  // from <boost/beast/websocket.hpp>
namespace net = boost::asio;             // from <boost/asio.hpp>
using tcp = boost::asio::ip::tcp;        // from <boost/asio/ip/tcp.hpp>

int main(int argc, char** argv) {
  try {
    // Check command line arguments.
    // verbose is a bool that prints desserialized messages to stdout if set
    // set at command line as "true" or "1"
    if (argc != 4) {
      std::cerr << "Usage: websocket-client-sync <host> <port> <verbose?>\n"
                << "Example:\n"
                << "    websocket-client-sync echo.websocket.org 80 \"Hello, "
                   "world!\"\n";
      return EXIT_FAILURE;
    }
    std::string host = argv[1];
    auto const port = argv[2];
    auto const verbose =
        (std::string(argv[3]) == "true" || std::string(argv[3]) == "1") ? true
                                                                        : false;
    auto const text =
        "{\"type\": \"subscribe\", \"product_ids\": [\"BTC-USD\"], "
        "\"channels\": [\"level2\", \"matches\"]}";
    // auto start = std::chrono::high_resolution_clock::now();
    uint64_t seconds_to_epoch = 0;
    uint64_t sec_to_ns = 1000000000;
    int price_digits = 2;
    int qty_digits = 8;

    // The io_context is required for all I/O
    net::io_context ioc;

    // These objects perform our I/O
    tcp::resolver resolver{ioc};
    websocket::stream<tcp::socket> ws{ioc};

    // Look up the domain name
    auto const results = resolver.resolve(host, port);

    // Make the connection on the IP address we get from a lookup
    auto ep = net::connect(ws.next_layer(), results);

    // Update the host_ string. This will provide the value of the
    // Host HTTP header during the WebSocket handshake.
    // See https://tools.ietf.org/html/rfc7230#section-5.4
    host += ':' + std::to_string(ep.port());

    // Set a decorator to change the User-Agent of the handshake
    ws.set_option(
        websocket::stream_base::decorator([](websocket::request_type& req) {
          req.set(http::field::user_agent,
                  std::string(BOOST_BEAST_VERSION_STRING) +
                      " websocket-client-coro");
        }));

    // Perform the websocket handshake
    ws.handshake(host, "/");

    // Send the message
    ws.write(net::buffer(std::string(text)));

    // This buffer will hold the incoming message
    beast::flat_buffer buffer;

    // Read a message into our buffer
    int actual_msgs = 0;

    for (;;) {
      // don't count subscriptions and snapshot in the 10000
      if (actual_msgs == 10000) {
        break;
      }
      ws.read(buffer);

      uint64_t exos_time =
          std::chrono::duration_cast<std::chrono::nanoseconds>(
              std::chrono::high_resolution_clock::now().time_since_epoch())
              .count();
      uint64_t elapsedEpoch = exos_time / sec_to_ns;
      int64_t t_ns = exos_time % sec_to_ns;

      json j = json::parse(beast::buffers_to_string(buffer.data()));
      std::string type = j["type"];

      if (type == "subscriptions") {
        buffer.consume(buffer.size());
        continue;
      } else if (type == "snapshot") {
        // vendor_offset is 0
        // an l2 message for every bid/ask
        auto bids = j["bids"];
        auto asks = j["asks"];
        int bid_switch = bids.size();
        bids.insert(bids.end(), asks.begin(), asks.end());

        for (auto bids_iter = bids.begin(); bids_iter != bids.end();
             ++bids_iter) {
          int price_field = str_to_intfield((*bids_iter)[0], price_digits);
          int qty_field = str_to_intfield((*bids_iter)[1], qty_digits);

          auto idx = std::distance(bids.begin(), bids_iter);

          LevelSet ore_msg(1, t_ns, 0, 0, 0, 0, price_field, qty_field,
                           idx < bid_switch ? "buy" : "sell");
          std::array<LevelSet, 1> arr = {ore_msg};
          msgpack::sbuffer sbuf;
          msgpack::pack(sbuf, arr);

          if (verbose) {
            msgpack::object_handle oh =
                msgpack::unpack(sbuf.data(), sbuf.size());
            msgpack::object deserialized = oh.get();
            std::cout << deserialized << std::endl;
          }
        }
      } else {
        ++actual_msgs;
        std::string ts = j["time"];
        uint64_t vendor_time = EpochConverter(ts);
        int64_t vendor_offset = vendor_time - exos_time;

        if (elapsedEpoch > seconds_to_epoch) {
          seconds_to_epoch = elapsedEpoch;
          Time ore_msg(0, seconds_to_epoch);
          std::array<Time, 1> arr = {ore_msg};
          msgpack::sbuffer sbuf;
          msgpack::pack(sbuf, arr);

          if (verbose) {
            msgpack::object_handle oh =
                msgpack::unpack(sbuf.data(), sbuf.size());
            msgpack::object deserialized = oh.get();
            std::cout << deserialized << std::endl;
          }
        }

        if (type == "l2update") {
          int price_field = str_to_intfield(j["changes"][0][1], price_digits);
          int qty_field = str_to_intfield(j["changes"][0][2], qty_digits);
          LevelSet ore_msg(14, t_ns, vendor_offset, 0, 0, 0, price_field,
                           qty_field, j["changes"][0][0] == "buy");
          std::array<LevelSet, 1> arr = {ore_msg};
          msgpack::sbuffer sbuf;
          msgpack::pack(sbuf, arr);

          if (verbose) {
            msgpack::object_handle oh =
                msgpack::unpack(sbuf.data(), sbuf.size());
            msgpack::object deserialized = oh.get();
            std::cout << deserialized << std::endl;
          }
        }

        else if (type == "match") {
          auto price_field = str_to_intfield(j["price"], price_digits);
          auto qty_field = str_to_intfield(j["size"], qty_digits);
          Match ore_msg(11, t_ns, vendor_offset, 0, 0, 0, price_field,
                        qty_field, j["side"] == "buy" ? "b" : "s");
          std::array<Match, 1> arr = {ore_msg};
          msgpack::sbuffer sbuf;
          msgpack::pack(sbuf, arr);

          if (verbose) {
            msgpack::object_handle oh =
                msgpack::unpack(sbuf.data(), sbuf.size());
            msgpack::object deserialized = oh.get();
            std::cout << deserialized << std::endl;
          }
        }
      }

      // drain buffer
      buffer.consume(buffer.size());
    }

    // // timing data
    // auto stop = std::chrono::high_resolution_clock::now();
    // std::cout << "closing! after: "
    //           << std::to_string(
    //                  std::chrono::duration_cast<std::chrono::nanoseconds>(stop
    //                  -
    //                                                                       start)
    //                      .count())
    //           << std::endl;

    // Close the WebSocket connection
    ws.close(websocket::close_code::normal);
  } catch (std::exception const& e) {
    std::cerr << "Error: " << e.what() << std::endl;
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}
