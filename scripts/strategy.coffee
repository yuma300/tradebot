coincheck = require 'node-coincheck'
zaif = require 'zaif.jp'
async = require('async');
constant = require('./constant');


class Strategy
  execute: () ->
    async.series [
      (callback) ->
        api = coincheck.PublicApi;
        api.ticker (body) ->
          callback(null, body);
      (callback) ->
        api = zaif.PublicApi;
        api.ticker('btc_jpy').then (result) ->
          callback(null, result);
    ], (err, results) ->
      console.log(results)

    async.series [
      (callback) ->
        api = coincheck.createPrivateApi(constant.COINCHECK_API_KEY, constant.COINCHECK_SECRET_KEY, 'user agent is node-coincheck');
        api.getBalance (body) ->
          callback(null, body);
      (callback) ->
        callback(null, "hohoge");
    ], (err, results) ->
      console.log(results)
module.exports = Strategy
