LZString = require('lz-string')  # Assuming LZString is installed via npm
PREFIX = btoa "Cheater :(\n\n"  # Replace with your actual prefix

_splitVersionHeader = (encoded) ->
  versionDelimiterIndex = encoded.indexOf('|')
  if versionDelimiterIndex != -1
    return [encoded.substring(0, versionDelimiterIndex), encoded.substring(versionDelimiterIndex + 1)]
  else
    return [null, encoded]

decryptSaveState = (encoded) ->
  [saveversion, encoded] = _splitVersionHeader encoded
  encoded = encoded.substring PREFIX.length
  encoded = LZString.decompressFromBase64 encoded
  ret = JSON.parse encoded

  return ret

encryptSaveState = (decoded) ->
  encoded = JSON.stringify(decoded)
  encoded = LZString.compressToBase64(encoded)
  encoded = PREFIX + encoded
  encoded = "#{btoa "1.1.16"}#{"|"}#{encoded}"
  return encoded

# # Usage
# encodedSave = "MS4xLjE2|Q2hlYXRlciA6KAoKN4IgrgdglgLjCeAHApgZxALlFCA3KqUARgDbIAWAhjAMbnIBO8mIAjCADQgC2y1LAVgBMANgCcrIQDoA7DIAMAZjGcQJSg1yUW8qQBYxikXpGKzMgByqaAe1s2IO1TEYNYNpi0WslUoxdZJAQsBQxkBVWQIRgBzZgwQeVUGNBQaAFFohjinLm4YAA9M2PjE1WiCsHQEpK4aJlQYShJcnjAmmKjWxBTudspOxxrVSlQaKMIHVoAzFOQAJVTkGhY9VQATBgdkFlEBVkUpVhERVQBHMGQuhL0BWpBoxtaYlOpGC6uhsq5yKFwd4Y/P7ID7Xb4gZDcHpoargno2RD0GDPGzrdYw7qUCAwehTQEgRBYnHIBxCTHY3EQRTk4kONb4wkUkkQCL4mz/BjcHDrVrsxhciDrMlsjkC9bUkX87n08F8znc1my0Xc0741AAdw03BIOBiLDEolUjV1jFWRsQUHRDFa3BsqAu7laJDsVWR+K2lDozygRNQFqtrXG2KgKHRrU1fta6NwNjAKWt+JiNjx4OgMXIMCIYD1+NtONaRH4uf6FOodEYpXufSa2MLbvB1aJNGd0RtJZgGq1moYiDbNZgDCq5D7RL4XuL/dmIJH2IqVRnTU5ldUjexvCLZQAvlx1m9MKBGhoXDyEkJ5EI9ABac+X1gWAAqxwwAgEGHkMlkQiEAC1kmhF8euznleN53o+IjPq+76fj+RqUP8J4gGeF7XkIt4PqwMhvnoz66CIBy/lwKRQNMUDIIhyEgWhYGYdhuFSMEAiESAzZ2uRQEoaBGEQS+b4fjIX6/tuIAIjAUAONUwDCWAiAvJQ6KSSAVC0PQng3BsWzRPCiHsDumnIDA6o4F4RrdtquqGcZp6RAUjKTF8VhcKCEDaSwukgMaECdAwllfGSwmHmJxo0IpRDwAAqtAbqgJs2z7ixOo0AA1tURhcBAYDcG5igWGsXC+RlWUJCIQhmJE6iIKg5EAGJQAwTwYAYBgCMJznxc2UDJalejpZlLAlTIzhGRAhX9UIg1cMgFVVestX1W6rB6HISgBWZOpee1iUpZgQgCL1RUgIo8j3AVfUJAapyTdNNV1Q1X56Ho54BWJXmmlgCWddtGCsPtblDTgo3qVdlCVTd82YAID0yHoQibsJYXhbJDDyQCoDKeWamgB1XWYD1DxnSAeUQtds23QtX5CLlwmxVpWwnljW3VD9+MHe5U0gzNc0NQcFjjRY1P6b5m2falv0JNSwOg6T4PfcYIhU1wnacutMRC+92NfUIYtIeVHNg3dQiLeNwnILZWL2cLOMYBY2uOcTevS3d0N6ItrWXFErnq4zmDM4DbC61LXNunoiiiDDz0mj5w2W19vsE2Skuc2TuMWBIhtw3U3vfZhwmer8yD/Lw2KKTTyDsI1YjNU57sQOXi3LYoenbMKmHeCHk1mxA9nl+ND2LYra26j3y0CCI+XtB4PotBgigyAaih6MJmoqexWABUlIahgAslAJA6tU8hcByFvvYePmr2wRxHJdHnwRfrBX8cIDUzY3CUDgdBYp0ADCzozZgA5LibiAA=="
# 
# console.log(decodedSaveState)

# decode savestate & save to saveState.json
fs = require 'fs'
require.extensions['.txt'] = (module, filename) ->
  module.exports = fs.readFileSync filename, 'utf8'

encodedSaveState = require('./encryptedSave.txt')
decodedSaveState = decryptSaveState(encodedSaveState)

fs.writeFileSync 'saveState.json', JSON.stringify(decodedSaveState, null, 2)
console.log("wrote encrypted save to saveState.txt")


# encode cheated savestate
saveState = require('./cheatedSaveState.json')
console.log(encryptSaveState(saveState))