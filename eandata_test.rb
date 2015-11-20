#scratch file for smartTrashCan app. Used to connect to eandata.com barcode API

require 'rest-client'

response = JSON.parse(RestClient.get 'http://eandata.com/feed/?v=3&keycode=INSERTAPICODE&mode=json&find=0026100006568')
data = JSON.parse(response)
puts response['product']['attributes']['product']
