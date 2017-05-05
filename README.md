# _Volunteer Tracker_

#### _Website to track volunteers, projects, and project leaders 5/5/17_

#### By _**Eric Schoettle**_

## Description

_This website allows a non-profit organization to keep track of volunteers, projects, and project leaders. Projects may have multiple volunteers and volunteers may have multiple projects, though projects may have only one leader (that is, volunteers:projects is many-to-many whereas leaders:projects is one-to-many)_

_The website offers full CRUD functionality: projects, volunteers, and leaders may all be created, read, updated, and deleted_

## Setup/Installation Requirements

_This website requires setup of a SQL database in order to function. To set up the necessary database with postgres and PSQL on a mac, follow the following instructions:_

## Specifications

* _Constructor will make a pizza object with toppings, crust, size, and price traits_

* _Object of pizza sizes will be created_
  * _eg. sizes = small, medium, large, xl_
* _Pizza sizes will be objects with associated diameters and pricing_
  * _eg small.diameter = 10 inch, small.price = 8_
* _The Pizza object will be able to get a size object from the pizza sizes object_
    _eg pizza.size = {}_
*               _&              => pizza.size = medium_
    _sizes.medium is an object_

* _Object of pizza crusts will be created_
  * _eg. crusts = thin, whole wheat, gluten-free rubber_
* _Pizza crusts will be objects with associated pricing surcharges_
  * _eg wheat = +10%_
* _The Pizza object will be able to get a crust object from the pizza crusts object_
    _eg pizza.crust = {}_
*               _&              => pizza.crust = wheat_
    _crusts.wheat_

* _An object of all topping choices will be created_
* _An object of pizza toppings will be created inside of pizza_
* _pizza.toppings will be populated with selections from the topping choices object_

* _Pizza Price prototype will add up prices of size, crust, and toppings_
* _Order object will contain pizza objects, an address object, delivery method (pick up vs. delivery), and a total price_
* _Order object will contain a totalPrice prototype to add up the price of the order_
* _Program will convert camelCase to title case_
* _UI will allow users to select a pizza size using radio buttons_
* _UI will allow users to select a pizza crust using radio buttons_
* _UI will allow users to select toppings with checkboxes_
* _UI will show pizza price to user_


## Known Bugs

_There are no known bugs at this time_

## Technologies Used

_This website was built using Javascript, Jquery, and Bootstrap_

### License

*This software is licensed under the MIT license*

Copyright (c) 2016 **_Eric Schoettle_**
