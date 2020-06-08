//
//  Todo.swift
//  Medium
//
//  Created by Gabriela Bezerra on 07/06/20.
//

import Foundation

struct Organization: Codable {
    let id: Int?
    let bridgeId: Int?
    let name: String?
    let url: String?
}

struct Project: Codable {
    let id: Int
    let region: String
    let organization: Organization
    let active: Bool
    let title: String
    let summary: String
    let projectLink: String
    let contactURL: String?
    let goal: Double
    let funding: Double
    let remaining: Double
    let numberOfDonations: Int
}

/*
 {
   "id": 22098,
   "organization": {
     "id": 6395,
     "bridgeId": 1982634206,
     "name": "Iracambi",
     "ein": "52-2314396",
     "addressLine1": "Fazenda Iracambi",
     "addressLine2": "",
     "city": "Rosario da Limeira",
     "state": "MG",
     "postal": "36878-000",
     "iso3166CountryCode": "BR",
     "url": "http://en.iracambi.com/",
     "logoUrl": "https://www.globalgiving.org/pfil/organ/6395/orglogo.jpg",
     "mission": "Located in one of the worlds top five biodiversity hotspots: Brazil's Atlantic Forest, Iracambi's vision is Saving Forests, Changing Lives, and our mission is Awakening Environmental Awareness among local communities and Restoring the Atlantic Forest.",
     "totalProjects": 11,
     "activeProjects": 4,
     "themes": {
       "theme": [
         {
           "id": "children",
           "name": "Children"
         },
         {
           "id": "climate",
           "name": "Climate Change"
         },
         {
           "id": "ecdev",
           "name": "Economic Development"
         },
         {
           "id": "edu",
           "name": "Education"
         },
         {
           "id": "env",
           "name": "Environment"
         },
         {
           "id": "rights",
           "name": "Human Rights"
         }
       ]
     },
     "countries": {
       "country": [
         {
           "name": "Brazil",
           "iso3166CountryCode": "BR"
         },
         {
           "name": "United States",
           "iso3166CountryCode": "US"
         }
       ]
     },
     "country": "Brazil"
   },
   "active": true,
   "title": "Forests4Water Brazil: Community forest restoration",
   "summary": "Here in Brazil we've already planted 100,000 native rainforest trees and this year we aim to plant another 10,000! Why? Because springs are running dry, farmers are losing their crops and city water supplies are threatened. Healthy forests increase soil fertility, regenerate springs and allow rain clouds to form, attacking the water crisis at its root. Restoring the forest restores the water, while trees absorb carbon to combat climate change - a win-win for the forest, the farmers and us all.",
   "contactName": "Alielle Canedo",
   "contactAddress": "Iracambi Rainforest Research Center",
   "contactCity": "Rosario da Limeira",
   "contactState": "MG",
   "contactPostal": "36878-000",
   "contactCountry": "Brazil",
   "contactUrl": "http://en.iracambi.com/",
   "projectLink": "https://www.globalgiving.org/projects/forests-4-water/",
   "progressReportLink": "https://www.globalgiving.org/projects/forests-4-water/updates/",
   "themeName": "Environment",
   "country": "Brazil",
   "iso3166CountryCode": "BR",
   "region": "South/Central America and the Caribbean",
   "goal": 73000.00,
   "funding": 44415.08,
   "remaining": 28584.92,
   "numberOfDonations": 860,
   "status": "active",
   "need": "The world is facing a water crisis, and one of the root causes is that we're overstraining planetary resources. For too long we've cleared forests for agriculture, industry and urban expansion, and now we're suffering the consequences. Without forests to protect our soils and water, we're all directly affected: whether you're a Brazilian coffee farmer facing crop failure, or a resident of California facing water restrictions. We need to act now and we need to start where we are. Please join us!",
   "longTermImpact": "Our dream is to create a pilot program that is easily scaled and easily adaptable, drawing on simple technologies and the power of concerned citizens everywhere. Through thinking globally and acting locally we can directly impact thousands of people in this forest region, and millions of people across the world. Together we'll restore damaged ecosystems, save rainforests, protect and renew water supplies, combat climate change, plant trees, and plant hope for a better future.",
   "activities": "Building on our successful reforestation model, we've expanded our forest nursery to produce more native tree seedlings. We're working with local farming communities to reforest near springs and along stream banks, selecting productive tree species to bring economic gains while protecting water sources. We'll extend our informal education program and assemble a team of young people to spread the word, plant trees, create more habitat for wildlife, and protect our most precious asset: fresh water",
   "imageLink": "https://www.globalgiving.org/pfil/22098/pict.jpg",
   "imageGallerySize": 10,
   "longitude": -42.51150894165039,
   "latitude": -20.982925415039062,
   "approvedDate": "2015-11-06T16:33:37-05:00",
   "donationOptions": {
     "donationOption": [
       {
         "amount": 10,
         "description": "Plant 1 tree"
       },
       {
         "amount": 25,
         "description": "Plant 2 trees + 2 years of monitoring and maintenance"
       },
       {
         "amount": 50,
         "description": "Plant 4 trees + 2 years of monitoring and maintenance"
       },
       {
         "amount": 125,
         "description": "Plant 10 trees + 2 years of monitoring and maintenance"
       },
       {
         "amount": 250,
         "description": "Plant 20 trees + 2 years of monitoring and maintenance"
       },
       {
         "amount": 500,
         "description": "Plant 40 trees + 2 years of monitoring and maintenance"
       },
       {
         "amount": 1250,
         "description": "Plant 100 trees + 2 years of monitoring and maintenance"
       },
       {
         "amount": 2000,
         "description": "Restore 1 full water spring (200 trees)"
       }
     ]
   },
   "countries": {
     "country": [
       {
         "name": "Brazil",
         "iso3166CountryCode": "BR"
       }
     ]
   },
   "image": {
     "title": "Forests4Water Brazil: Community forest restoration",
     "id": 0,
     "imagelink": [
       {
         "url": "https://www.globalgiving.org/pfil/22098/pict_grid1.jpg",
         "size": "small"
       },
       {
         "url": "https://www.globalgiving.org/pfil/22098/pict_thumbnail.jpg",
         "size": "thumbnail"
       },
       {
         "url": "https://www.globalgiving.org/pfil/22098/pict_med.jpg",
         "size": "medium"
       },
       {
         "url": "https://www.globalgiving.org/pfil/22098/pict_grid7.jpg",
         "size": "large"
       },
       {
         "url": "https://www.globalgiving.org/pfil/22098/pict_large.jpg",
         "size": "extraLarge"
       },
       {
         "url": "https://www.globalgiving.org/pfil/22098/pict_original.jpg",
         "size": "original"
       }
     ]
   },
   "themes": {
     "theme": [
       {
         "id": "env",
         "name": "Environment"
       },
       {
         "id": "climate",
         "name": "Climate Change"
       },
       {
         "id": "ecdev",
         "name": "Economic Development"
       },
       {
         "id": "edu",
         "name": "Education"
       }
     ]
   },
   "type": "project"
 },
 */
