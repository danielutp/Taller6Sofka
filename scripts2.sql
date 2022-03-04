CREATE SCHEMA IF NOT EXISTS store DEFAULT CHARACTER SET utf8;
USE store;

-- -----------------------------------------------------
-- Table seller
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seller (
  id_seller INT NOT NULL AUTO_INCREMENT,
  name_seller VARCHAR(45) NOT NULL,
  create_at DATE NULL,
  update_at DATE NULL,
  delete_at DATE NULL,
  PRIMARY KEY (id_seller),
  UNIQUE INDEX id_seller_UNIQUE (id_seller ASC) VISIBLE,
  UNIQUE INDEX name_seller_UNIQUE (name_seller ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product (
  id_product INT NOT NULL AUTO_INCREMENT,
  name_product VARCHAR(45) NOT NULL,
  price_product DOUBLE NOT NULL,
  create_at  DATE NOT NULL,
  update_at DATE NULL,
  delete_at DATE NULL,
  PRIMARY KEY (id_product))
ENGINE = InnoDB;

select * from product;

SELECT p.id_product,p.name_product,p.price_product
FROM product p
where p.price_product = (select max(p2.price_product) from product p2 where p2.id_product = p.id_product)
GROUP BY p.id_product;
-- HAVING SUM(p.price_product);
--
-- -----------------------------------------------------
-- Table supplier
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS supplier (
  id_supplier INT NOT NULL AUTO_INCREMENT,
  name_supplier VARCHAR(45) NOT NULL,
  create_at DATE NOT NULL,
  update_at DATE NULL,
  delete_at DATE NULL,
  PRIMARY KEY (id_supplier),
  UNIQUE INDEX name_supplier_UNIQUE (name_supplier ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table type_of_document
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS type_of_document (
  id_type_of_document INT NOT NULL AUTO_INCREMENT,
  name_document VARCHAR(45) NOT NULL,
  create_at DATE NOT NULL,
  update_at DATE NULL,
  delete_at DATE NULL,
  PRIMARY KEY (id_type_of_document))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table customer
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS customer (
  id_customer INT NOT NULL AUTO_INCREMENT,
  type_of_document_id_type_of_document INT NOT NULL,
  name_customer VARCHAR(45) NOT NULL,
  number_document VARCHAR(12) NOT NULL,
  create_at DATE NOT NULL,
  update_at DATE NULL,
  delete_at DATE NULL,
  PRIMARY KEY (id_customer),
  INDEX fk_customer_type_of_document_idx (type_of_document_id_type_of_document ASC) VISIBLE,
  UNIQUE INDEX number_document_UNIQUE (number_document ASC, type_of_document_id_type_of_document ASC) VISIBLE,
  CONSTRAINT fk_customer_type_of_document
    FOREIGN KEY (type_of_document_id_type_of_document)
    REFERENCES type_of_document (id_type_of_document)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table invoice
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS invoice (
  id_invoice INT NOT NULL AUTO_INCREMENT,
  seller_id_seller INT NOT NULL,
  customer_id_customer INT NOT NULL,
  date_invoice DATE NOT NULL,
  update_at DATE NULL,
  delete_at DATE NULL,
  PRIMARY KEY (id_invoice),
  INDEX fk_invoice_seller1_idx (seller_id_seller ASC) VISIBLE,
  INDEX fk_invoice_customer1_idx (customer_id_customer ASC) VISIBLE,
  UNIQUE INDEX id_invoice_UNIQUE (id_invoice ASC) VISIBLE,
  CONSTRAINT fk_invoice_seller1
    FOREIGN KEY (seller_id_seller)
    REFERENCES seller (id_seller)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_invoice_customer1
    FOREIGN KEY (customer_id_customer)
    REFERENCES customer (id_customer)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table product_has_invoice
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product_has_invoice (
  id_product_invoice INT NOT NULL AUTO_INCREMENT,
  product_id_product INT NOT NULL,
  invoice_id_invoice INT NOT NULL,
  INDEX fk_product_has_invoice_invoice1_idx (invoice_id_invoice ASC) VISIBLE,
  INDEX fk_product_has_invoice_product1_idx (product_id_product ASC) VISIBLE,
  PRIMARY KEY (id_product_invoice),
  CONSTRAINT fk_product_has_invoice_product1
    FOREIGN KEY (product_id_product)
    REFERENCES product (id_product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_product_has_invoice_invoice1
    FOREIGN KEY (invoice_id_invoice)
    REFERENCES invoice (id_invoice)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table product_has_supplier
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product_has_supplier (
  id_product_supplier INT NOT NULL AUTO_INCREMENT,
  supplier_id_supplier INT NOT NULL,
  product_id_product INT NOT NULL,
  PRIMARY KEY (id_product_supplier),
  INDEX fk_product_has_supplier_supplier1_idx (supplier_id_supplier ASC) VISIBLE,
  UNIQUE INDEX id_product_supplier_UNIQUE (id_product_supplier ASC, supplier_id_supplier ASC, product_id_product ASC) VISIBLE,
  INDEX fk_product_has_supplier_product1_idx (product_id_product ASC) VISIBLE,
  CONSTRAINT fk_product_has_supplier_supplier1
    FOREIGN KEY (supplier_id_supplier)
    REFERENCES supplier (id_supplier)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_product_has_supplier_product1
    FOREIGN KEY (product_id_product)
    REFERENCES product (id_product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Datos de la table seller
-- -----------------------------------------------------
insert into seller(id_seller,name_seller,create_at,update_at,delete_at)
value(1,'Daniel',"2022-01-02",null,null);

-- -----------------------------------------------------
-- Datos de la table product
-- -----------------------------------------------------
insert into product(id_product,name_product,price_product,create_at,update_at,delete_at)
value(1,'papa',10.000,"2022-01-01",null,null);
insert into product(id_product,name_product,price_product,create_at,update_at,delete_at)
value(2,'arroz',9.000,"2022-01-01",null,null);
insert into product(id_product,name_product,price_product,create_at,update_at,delete_at)
value(3,'huevo',1.000,"2022-01-01",null,null);
insert into product(id_product,name_product,price_product,create_at,update_at,delete_at)
value(4,'miel',8.000,"2022-01-01",null,null);
insert into product(id_product,name_product,price_product,create_at,update_at,delete_at)
value(5,'cebolla',1.000,"2022-01-01",null,null);
insert into product(id_product,name_product,price_product,create_at,update_at,delete_at)
value(6,'torta',7.000,"2022-01-01",null,null);
insert into product(id_product,name_product,price_product,create_at,update_at,delete_at)
value(7,'pan',2.000,"2022-01-01",null,null);

-- -----------------------------------------------------
-- Datos de la table supplier
-- -----------------------------------------------------
insert into supplier(id_supplier,name_supplier,create_at,update_at,delete_at)
value(1,'Colanta',"2022-01-01",null,null);
insert into supplier(id_supplier,name_supplier,create_at,update_at,delete_at)
value(2,'Alberto',"2022-01-01",null,null);
insert into supplier(id_supplier,name_supplier,create_at,update_at,delete_at)
value(3,'Mieltos',"2022-01-01",null,null);
insert into supplier(id_supplier,name_supplier,create_at,update_at,delete_at)
value(4,'HuevosK',"2022-01-01",null,null);
insert into supplier(id_supplier,name_supplier,create_at,update_at,delete_at)
value(5,'milla',"2022-01-01",null,null);

-- -----------------------------------------------------
-- Datos de la  table type_of_document
-- -----------------------------------------------------
insert into type_of_document(id_type_of_document,name_document,create_at,update_at,delete_at)
value(1,'Cedula',"2022-01-01",null,null);
insert into type_of_document(id_type_of_document,name_document,create_at,update_at,delete_at)
value(2,'Tarjeta identidad',"2022-01-01",null,null);
insert into type_of_document(id_type_of_document,name_document,create_at,update_at,delete_at)
value(3,'Pasaporte',"2022-01-01",null,null);

-- -----------------------------------------------------
-- Datos de la table customer
-- -----------------------------------------------------
insert into customer(id_customer,type_of_document_id_type_of_document,name_customer,number_document,create_at,update_at,delete_at)
value(1,1,'Carlos','10882541347',"2022-01-01",null,null);
insert into customer(id_customer,type_of_document_id_type_of_document,name_customer,number_document,create_at,update_at,delete_at)
value(2,2,'Martina','10882341347',"2022-01-01",null,null);
insert into customer(id_customer,type_of_document_id_type_of_document,name_customer,number_document,create_at,update_at,delete_at)
value(3,3,'Paula','10882541347',"2022-01-01",null,null);

-- -----------------------------------------------------
-- Datos de la  table invoice
-- -----------------------------------------------------
insert into invoice(id_invoice,seller_id_seller,customer_id_customer,date_invoice,update_at,delete_at)
value(1,1,1,"2022-01-02",null,null);
insert into invoice(id_invoice,seller_id_seller,customer_id_customer,date_invoice,update_at,delete_at)
value(2,1,2,"2022-01-02",null,null);
insert into invoice(id_invoice,seller_id_seller,customer_id_customer,date_invoice,update_at,delete_at)
value(3,1,3,"2022-01-02",null,null);
insert into invoice(id_invoice,seller_id_seller,customer_id_customer,date_invoice,update_at,delete_at)
value(4,1,3,"2022-01-02",null,null);
insert into invoice(id_invoice,seller_id_seller,customer_id_customer,date_invoice,update_at,delete_at)
value(5,1,3,"2022-01-02",null,null);
insert into invoice(id_invoice,seller_id_seller,customer_id_customer,date_invoice,update_at,delete_at)
value(6,1,3,"2022-01-02",null,null);
insert into invoice(id_invoice,seller_id_seller,customer_id_customer,date_invoice,update_at,delete_at)
value(7,1,3,"2022-01-02",null,null);

-- -----------------------------------------------------
-- Datos de la table product_has_supplier
-- -----------------------------------------------------
insert into product_has_supplier(id_product_supplier,product_id_product,supplier_id_supplier)
value(1,1,1);
insert into product_has_supplier(id_product_supplier,product_id_product,supplier_id_supplier)
value(2,2,2);
insert into product_has_supplier(id_product_supplier,product_id_product,supplier_id_supplier)
value(3,3,1);
insert into product_has_supplier(id_product_supplier,product_id_product,supplier_id_supplier)
value(4,4,2);
insert into product_has_supplier(id_product_supplier,product_id_product,supplier_id_supplier)
value(5,5,4);

-- -----------------------------------------------------
-- Datos de la table product_has_invoice
-- -----------------------------------------------------
insert into product_has_invoice(id_product_invoice,product_id_product,invoice_id_invoice)
value(1,1,1);
insert into product_has_invoice(id_product_invoice,product_id_product,invoice_id_invoice)
value(2,2,2);
insert into product_has_invoice(id_product_invoice,product_id_product,invoice_id_invoice)
value(3,1,3);
insert into product_has_invoice(id_product_invoice,product_id_product,invoice_id_invoice)
value(4,1,4);
insert into product_has_invoice(id_product_invoice,product_id_product,invoice_id_invoice)
value(5,2,5);
insert into product_has_invoice(id_product_invoice,product_id_product,invoice_id_invoice)
value(6,1,6);
insert into product_has_invoice(id_product_invoice,product_id_product,invoice_id_invoice)
value(7,3,7);

-- -----------------------------------------------------
-- Obtener los producto vendidos con un tipo de documento y numero de documento
-- -----------------------------------------------------
select product.* from customer
join invoice
on customer.id_customer = invoice.customer_id_customer
join product_has_invoice
on customer.id_customer = product_has_invoice.invoice_id_invoice
join product
on product_has_invoice.product_id_product = product.id_product
where customer.type_of_document_id_type_of_document = 1
and customer.number_document = '10882541347';

-- -----------------------------------------------------
-- Obtener el proveedor por el nombre del producto
-- -----------------------------------------------------
select product_has_supplier.supplier_id_supplier from product
left join product_has_supplier
on product.id_product = product_has_supplier.product_id_product
where product.name_product = 'arroz';

-- -----------------------------------------------------
-- Producto mas vendido de mayor a menor
-- -----------------------------------------------------
SELECT product.name_product, count(*) cantidad FROM product
join product_has_invoice
on product.id_product = product_has_invoice.product_id_product
GROUP BY product.id_product
ORDER BY cantidad DESC;