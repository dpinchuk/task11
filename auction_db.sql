CREATE SCHEMA `auction_db` DEFAULT CHARACTER SET utf8;

USE `auction_db`;

/*Create table of buyers with name, lastname*/
CREATE TABLE `auction_db`.`buyers` (
  `id_buyer` INT NOT NULL AUTO_INCREMENT, /*buyer id*/
  `name_buyer` VARCHAR(45) NOT NULL, /*buyer  name*/
  `lastname_buyer` VARCHAR(45) NOT NULL, /*buyer lastname*/
  PRIMARY KEY (`id_buyer`));

  

/*
INSERT INTO buyers VALUES
  (1, 'Iosiph', 'Stalin'),
  (2, 'Vladimir', 'Lenin'),
  (3, 'Lev', 'Trockiy'),
  (4, 'Adolf', 'Hitler');
*/



/*Create table of sellers with name, lastname*/
CREATE TABLE `auction_db`.`sellers` (
  `id_seller` INT NOT NULL AUTO_INCREMENT, /*seller id*/
  `name_seller` VARCHAR(45) NOT NULL, /*seller name*/
  `lastname_seller` VARCHAR(45) NOT NULL, /*seller lastname*/
  PRIMARY KEY (`id_seller`));

  

/*  
INSERT INTO sellers VALUES
  (1, 'Dima', 'Pinchuk'),
  (2, 'Evgeniy', 'Tyapunoff');
*/



/*Create table of products for sale with name, star price and count*/
CREATE TABLE `auction_db`.`products` (
  `id_product` INT NOT NULL AUTO_INCREMENT, /*product id*/
  `name_product` VARCHAR(45) NOT NULL, /*product name*/
  `start_price_product` INT NOT NULL, /*start price for auction sales*/
  `count_product` INT NOT NULL, /*counts of items*/
  `lot_size` INT NOT NULL, /*lot size for increment price during auction sales*/
  PRIMARY KEY (`id_product`));

  

/*
INSERT INTO products VALUES
  (1, 'Old Table 1890', 2000, 1, 100),
  (2, 'Old chair 1888', 1200, 2, 100),
  (3, 'Old knife 235', 3800, 1, 100),
  (4, 'Old Gold Coin -380', 5000, 1, 100),
  (5, 'Old mark 1809', 2400, 1, 100);
*/

  

/*Create table of sellers bids with id, productID, buyerID, priceWantToBuyProduct, purchase price*/
CREATE TABLE `auction_db`.`asks` (
  `id_ask` INT NOT NULL AUTO_INCREMENT, /*ask id*/
  `id_product_ask` INT NOT NULL, /*product id*/
  `id_buyer_ask` INT NOT NULL, /*buyer id*/
  `price_want_to_buy` INT NOT NULL, /*The price at which the buyer wanted to buy the product*/
  `purchase_price` INT NOT NULL, /*The price at which the buyer bought the product*/
  PRIMARY KEY (`id_ask`),
  INDEX `id_product_ask_idx` (`id_product_ask` ASC),
  INDEX `id_buyer_ask_idx` (`id_buyer_ask` ASC),
  CONSTRAINT `id_product_ask`
    FOREIGN KEY (`id_product_ask`)
    REFERENCES `auction_db`.`products` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_buyer_ask`
    FOREIGN KEY (`id_buyer_ask`)
    REFERENCES `auction_db`.`buyers` (`id_buyer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	
	

/*
INSERT INTO asks VALUE
(NULL, 
(SELECT id_product FROM products WHERE name_product = 'Old Table 1890'), 
(SELECT id_buyer FROM buyers WHERE name_buyer = 'Iosiph'), 
2500, 5500),

(NULL, 
(SELECT id_product FROM products WHERE name_product = 'Old chair 1888'), 
(SELECT id_buyer FROM buyers WHERE name_buyer = 'Vladimir'), 
2000, 4500),

(NULL, 
(SELECT id_product FROM products WHERE name_product = 'Old knife 235'), 
(SELECT id_buyer FROM buyers WHERE name_buyer = 'Iosiph'), 
4000, 4500),

(NULL, 
(SELECT id_product FROM products WHERE name_product = 'Old mark 1809'), 
(SELECT id_buyer FROM buyers WHERE name_buyer = 'Adolf'), 
3000, 3500),

(NULL, 
(SELECT id_product FROM products WHERE name_product = 'Old Gold Coin -380'), 
(SELECT id_buyer FROM buyers WHERE name_buyer = 'Adolf'), 
6500, 9500),

(NULL, 
(SELECT id_product FROM products WHERE name_product = 'Old chair 1888'), 
(SELECT id_buyer FROM buyers WHERE name_buyer = 'Adolf'), 
2500, 6500);
*/

	

/*Create table of sellers bids with id, productID, sellerID, priceWantToSaleProduct, selling price*/  
CREATE TABLE `auction_db`.`bids` (
  `id_bids` INT NOT NULL AUTO_INCREMENT, /*bid id*/
  `id_product_bid` INT NOT NULL, /*product id*/
  `id_seller_bid` INT NOT NULL, /*seller id*/
  `price_want_to_sale` INT NOT NULL, /*The price at which the seller wants to sell the ptoduct*/
  `selling_price` INT NULL, /*The price at which the seller sold the product*/
  PRIMARY KEY (`id_bids`),
  INDEX `id_product_bid_idx` (`id_product_bid` ASC),
  INDEX `id_seller_bid_idx` (`id_seller_bid` ASC),
  CONSTRAINT `id_product_bid`
    FOREIGN KEY (`id_product_bid`)
    REFERENCES `auction_db`.`products` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_seller_bid`
    FOREIGN KEY (`id_seller_bid`)
    REFERENCES `auction_db`.`sellers` (`id_seller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	
	

/*
INSERT INTO bids VALUE
(NULL, 
(SELECT id_product FROM products WHERE name_product = 'Old Table 1890'), 
(SELECT id_seller FROM sellers WHERE name_seller = 'Dima'), 
5000, 5500),

(NULL, 
(SELECT id_product FROM products WHERE name_product = 'Old chair 1888'), 
(SELECT id_seller FROM sellers WHERE name_seller = 'Evgeniy'), 
5000, 6500),

(NULL, 
(SELECT id_product FROM products WHERE name_product = 'Old chair 1888'), 
(SELECT id_seller FROM sellers WHERE name_seller = 'Dima'), 
4000, 4500),

(NULL, 
(SELECT id_product FROM products WHERE name_product = 'Old knife 235'), 
(SELECT id_seller FROM sellers WHERE name_seller = 'Dima'), 
8000, 4500),

(NULL, 
(SELECT id_product FROM products WHERE name_product = 'Old mark 1809'), 
(SELECT id_seller FROM sellers WHERE name_seller = 'Evgeniy'), 
4000, 3500),

(NULL, 
(SELECT id_product FROM products WHERE name_product = 'Old Gold Coin -380'), 
(SELECT id_seller FROM sellers WHERE name_seller = 'Evgeniy'), 
10000, 9500);
*/



/*Auction results*/
CREATE TABLE `auction_db`.`sales_result` (
  `id_result` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `start_price` INT NOT NULL,
  `sale_price` INT NOT NULL,
  `seller_id` INT NOT NULL,
  `buyer_id` INT NOT NULL,
  PRIMARY KEY (`id_result`),
  INDEX `product_id_idx` (`product_id` ASC),
  INDEX `seller_id_idx` (`seller_id` ASC),
  INDEX `buyer_id_idx` (`buyer_id` ASC),
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `auction_db`.`products` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `seller_id`
    FOREIGN KEY (`seller_id`)
    REFERENCES `auction_db`.`sellers` (`id_seller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `buyer_id`
    FOREIGN KEY (`buyer_id`)
    REFERENCES `auction_db`.`buyers` (`id_buyer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);