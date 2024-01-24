# CHANGELOG

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
