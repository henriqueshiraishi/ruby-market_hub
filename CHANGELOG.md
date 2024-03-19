# CHANGELOG

## [0.23.5] - 2024-03-19

- Fix find with merge in Variation Model

## [0.23.4] - 2024-03-15

- Fix assign channel to variable in Item Model

## [0.23.3] - 2024-03-15

- Fix assign id to variable in Item Model

## [0.23.2] - 2024-03-15

- Fix check new? method in Base Model

## [0.23.1] - 2024-03-14

- Fix nomenclature in Item Model (MercadoLivre)

## [0.23.0] - 2024-03-14

- Add Item Model to MercadoLivre
- Add Variation Model to MercadoLivre
- Fix item_id argument in variation class API

## [0.22.0] - 2024-03-12

- Add domain method in category module

## [0.21.0] - 2024-03-11

- Add billing_info method in order module

## [0.20.0] - 2024-01-30

- Add find, create, update and errors to MercadoLivre::Invoice
- Add billing_info type to MercadoLivre::Shipment
- Add invoice objects to MercadoLivre::Client
- Fix content type application/xml in HTTP module

## [0.19.0] - 2024-01-29

- Add find and labels to MercadoLivre::Shipment
- Add order and shipment objects to MercadoLivre::Client

## [0.18.0] - 2024-01-29

- Add all, recent, find and notes to MercadoLivre::Order

## [0.17.0] - 2024-01-29

- Change attributes method with new tag argument
- Add validation and Error class to Models
- Add news methods to MercadoLivre::Client
- Add base code to Base class (API and Model)

## [0.16.0] - 2024-01-25

- Add metrics, all, find, anwser and destroy to MercadoLivre::QuestionAnswer

## [0.15.0] - 2024-01-24

- Add all, find, create, update and destroy to MercadoLivre::Variation
- Add delete verb to HTTP module

## [0.14.1] - 2024-01-24

- Remove excess space
- Add optional header argument in the HTTP module
- Change attributes in MarketHub::Configuration

## [0.14.0] - 2024-01-23

- Add all, find and optin to MercadoLivre::Catalog

## [0.13.0] - 2024-01-23

- Add me and currency to MercadoLivre::User
- Fix destroy method in MercadoLivre::Item

## [0.12.2] - 2024-01-22

- Add currency_id in MarketHub::Configuration

## [0.12.1] - 2024-01-22

- Add layout Meli Item and change Meli Token Test

## [0.12.0] - 2024-01-22

- Add upload, add and change to MercadoLivre::Image
- Change HTTP module to support file upload

## [0.11.0] - 2024-01-21

- Add find, create and update to MercadoLivre::Description

## [0.10.0] - 2024-01-21

- Change tests with global token variables
- Add sale_terms to MercadoLivre::Category
- Add all, find, find_by_sku, create, update and destroy to MercadoLivre::Item
- Add post_form and put to HTTP module
- Change HTTP module to simplify code patters

## [0.9.0] - 2024-01-18

- Add HTTP module to simplify HTTP requests
- Change all files that were using Net::HTTP

## [0.8.0] - 2024-01-18

- Add listing_types_availables, listing_types_downgrades, listing_types_upgrades and update in MercadoLivre::PublicationType

## [0.7.0] - 2024-01-18

- Add listing_types and listing_exposures methods in MercadoLivre::PublicationType

## [0.6.1] - 2024-01-18

- Fix test_o_auth_20 file

## [0.6.0] - 2024-01-18

- Add site, find and attributes methods in MercadoLivre::Category

## [0.5.0] - 2024-01-18

- Add predict_category in MercadoLivre::Category

## [0.4.0] - 2024-01-18

- Add MercadoLivre::Authorization with OAuth 2.0
- Change Utils::OAuth20 with new args and generic behavior

## [0.3.0] - 2024-01-18

- Organize library folders and classes

## [0.2.0] - 2024-01-12

- Add OAuth20 autentication method

## [0.1.0] - 2024-01-10

- Initial release
