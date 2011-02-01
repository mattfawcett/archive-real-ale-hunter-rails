Real Ale Hunter API
===================

This is a REST style API which allows access to search for pubs by name or town or the closest pubs based on your latitude and longitude. For a particular pub you can then make an API call to get images of the pub. The API will return Json for all API calls. The API is at http://www.realalehunter.co.uk/api

Pubs
----
### Search
The search can do 3 different types of search, all will return a Json array:

* For a general search which will search for your keyword in the name, description and username fields. You would make a http GET request to `http://www.realalehunter.co.uk/api/pubs/search/?q=Decent+Boozer` where `q` is the string you are searching for
* To search for all pubs in a certain town include a parameter called `by` with a value of `town`. SO for example to find pubs in Leeds, make a GET request to `http://www.realalehunter.co.uk/api/pubs/search/?by=town&q=Leeds`
* To search for pubs with a particular name, include a parameter called `by` with a value of `name`, so for example to find Mr Foleys, make a GET request to `http://www.realalehunter.co.uk/api/pubs/search/?by=name&q=Mr+Foleys`

#### Example request and response
    curl "http://www.realalehunter.co.uk/api/pubs/search/?by=name&q=Mr+Foleys" | prettify_json.rb
    
    [
      {
        "pub": {
          "name": "Mr Foleys Cask Ale House (Dr Okells)",
          "number_of_images": 2,
          "created_at": null,
          "gbg": true,
          "average_ratings": {
            "overall_option": 9,
            "price": 8,
            "beer_quality": 9,
            "atmosphere": 9,
            "beer_selection": 9
          },
          "cask_marque": false,
          "post_code": "LS1 5RG",
          "updated_at": "2009-11-14T13:13:05Z",
          "id": 100,
          "lng": -1.548750400543,
          "number_of_pumps": 10,
          "address_1": "The Headrow",
          "user_id": 3365,
          "address_2": "",
          "website": null,
          "description": "LEEDS CAMRA 'PUB OF THE YEAR 08/09'\n\r\n\n\r\nMr Foley's was opened in November 2007 in the ownership of York Brewery.\n\r\n\n\r\nThis pub has a good selection of guest beers on offer and also does a fair few foreign beers on tap including Peroni, Leffe, Morakva (british brewed, unpasturised czech lager) Krombacher Pils and Belle Vue. They also have a selection of over 25 bottled beers such as Sierra Nevada, Chimay and Brooklyn. The pub is a weird shape being on many different levels. There is the bar area at the bottom, and a raised seating area about 4 foot. Then on a slightly lower level is the back room which is very big with a few comfy sofas. This used to be the no smoking area before the ban and is sometimes closed off when there is a private function in there. There is also a small balcony/seating area that is over the bar.\n\r\n\n\r\nFood is served daily until 7PM\n\r\n\n\r\nAll major sporting events are shown on 3 large screens and live music can be found on occasional sunday evenings.",
          "telephone": "01132429674",
          "number_of_ratings": 4,
          "lat": 53.799503919886,
          "town": "Leeds"
        }
      }
    ]

    
### Closest
The closest API call allows you to send your latitude & longitude to get the pubs closest to you. You will get a Json array back. Make a http GET request to `http://www.realalehunter.co.uk/api/pubs/closest` with the following parameters:

* `lat` - your latitude
* `lon` - Your Longitude
* `limit` - An optional limit on the number to return (default: 5)

#### Example request and response
    curl "http://www.realalehunter.co.uk/api/pubs/closest/?lat=53.-1&lon=-1.5&limit=2" | prettify_json.rb
    
    [
      {
        "pub": {
          "name": "Lion Hotel",
          "number_of_images": 0,
          "created_at": "2008-10-18T14:22:30Z",
          "gbg": null,
          "average_ratings": null,
          "cask_marque": true,
          "post_code": "DE56 1AX",
          "updated_at": "2008-10-18T14:22:30Z",
          "id": 3617,
          "lng": -1.484545,
          "number_of_pumps": 0,
          "address_1": "Bridge Street",
          "user_id": 3364,
          "address_2": "",
          "website": "http://www.lionhotel.uk.com",
          "description": "The Lion Hotel, has a restaurant area.\nParking is available\n\nWebsite: ",
          "telephone": "01773 824 033",
          "number_of_ratings": 0,
          "lat": 53.024205,
          "town": "Belper",
          "distance": "1.7935675117662"
        }
      },
      {
        "pub": {
          "name": "Hanging Gate",
          "number_of_images": 1,
          "created_at": "2008-10-18T14:22:30Z",
          "gbg": null,
          "average_ratings": null,
          "cask_marque": true,
          "post_code": "DE56 2LE",
          "updated_at": "2008-10-18T14:22:30Z",
          "id": 4518,
          "lng": -1.523362,
          "number_of_pumps": 0,
          "address_1": "34 Ashbourne Road",
          "user_id": 3364,
          "address_2": "Shottle Gate",
          "website": "http://www.vintageinn.co.uk/thehanginggateshottlegate/",
          "description": "Website: \n\r\n\n\r\nThe Hanging Gate is well known in Shottle and across Derbyshire as a fine country pub. A popular pub restaurant famous for great food, we are nestled in the hamlet of Shottle Gate. There is always a warm welcome with roaring log fires, freshly prepared food, a great selection of real ales and a diverse wine menu for you to choose from.\n\r\n",
          "telephone": "01773 550467",
          "number_of_ratings": 0,
          "lat": 53.02211,
          "town": "Belper",
          "distance": "1.8122506521539"
        }
      }
    ]
    
### Show
The show call allows you to request details on a particular pub using the id from from one of the pubs in your search or closest API calls. You will receive a Json dictionary of the pub

#### Example request and response
    curl "http://www.realalehunter.co.uk/api/pubs/3617" | prettify_json.rb
  
    {
      "pub": {
        "name": "Lion Hotel",
        "number_of_images": 0,
        "created_at": "2008-10-18T14:22:30Z",
        "gbg": null,
        "average_ratings": null,
        "cask_marque": true,
        "post_code": "DE56 1AX",
        "updated_at": "2008-10-18T14:22:30Z",
        "id": 3617,
        "lng": -1.484545,
        "number_of_pumps": 0,
        "address_1": "Bridge Street",
        "user_id": 3364,
        "address_2": "",
        "website": "http://www.lionhotel.uk.com",
        "description": "The Lion Hotel, has a restaurant area.\nParking is available\n\nWebsite: ",
        "telephone": "01773 824 033",
        "number_of_ratings": 0,
        "lat": 53.024205,
        "town": "Belper"
      }
    }

Images
------

### Index
The index action allows you to get a Json array of images for a particular pub. You will need to pass us the pub id. There is a helper value in the `search`, `closest` and `show` pub API calls called `number_of_images` - if this is 0 then you could bypass the need to call to get images.

#### Example request and response
    curl "http://www.realalehunter.co.uk/api/pubs/100/images" | prettify_json.rb
  
    [
      {
        "image": {
          "attachment_file_name": "image78.jpg",
          "name": "An image of dr okells",
          "attachment_content_type": "image/jpeg",
          "attachment_file_size": 349696,
          "created_at": "2007-02-21T21:57:01Z",
          "files": {
            "medium": "/system/attachments/1241/medium/image78.jpg?1258040140",
            "thumb": "/system/attachments/1241/thumb/image78.jpg?1258040140",
            "big_thumb": "/system/attachments/1241/big_thumb/image78.jpg?1258040140",
            "original": "/system/attachments/1241/original/image78.jpg?1258040140"
          },
          "updated_at": "2007-02-21T21:57:01Z",
          "id": 1241,
          "user_id": 3364,
          "pub_id": 100,
          "attachment_updated_at": "2009-11-12T15:35:40Z"
        }
      },
      {
        "image": {
          "attachment_file_name": "image67.jpg",
          "name": "An image of dr okells",
          "attachment_content_type": "image/jpeg",
          "attachment_file_size": 357781,
          "created_at": "2007-02-21T18:35:13Z",
          "files": {
            "medium": "/system/attachments/1240/medium/image67.jpg?1258040137",
            "thumb": "/system/attachments/1240/thumb/image67.jpg?1258040137",
            "big_thumb": "/system/attachments/1240/big_thumb/image67.jpg?1258040137",
            "original": "/system/attachments/1240/original/image67.jpg?1258040137"
          },
          "updated_at": "2007-02-21T18:35:13Z",
          "id": 1240,
          "user_id": 3364,
          "pub_id": 100,
          "attachment_updated_at": "2009-11-12T15:35:37Z"
        }
      }
    ]
  