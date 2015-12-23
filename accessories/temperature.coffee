module.exports = (env) ->

  hap = require 'hap-nodejs'
  Service = hap.Service
  Characteristic = hap.Characteristic

  BaseAccessory = require('./base')(env)

  ##
  # TemperatureSensor
  ##
  class TemperatureAccessory extends BaseAccessory

    constructor: (device) ->
      super(device)

      @addService(Service.TemperatureSensor, device.name)
        .getCharacteristic(Characteristic.CurrentTemperature)
        .on 'get', (callback) =>
          @handleReturnPromise(device.getTemperature(), callback, null)

      device.on 'temperature', (temperature) =>
        @getService(Service.TemperatureSensor)
          .setCharacteristic(Characteristic.CurrentTemperature, temperature)