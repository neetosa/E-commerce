-- Criação do banco de dados para o cenário de E-commerce
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- Criar tabelas (Cliente, Produto e Pedido)

create table clients(
	idClient int primary key auto_increment,
    Fname varchar(10),
    Minit varchar(3),
    Lname varchar(20),
    CPF char(11) not null unique,
    Address varchar(225),
    constraint unique_cpf_client unique(CPF)
);

alter table clients auto_increment=1;

create table product(
	idProduct int primary key auto_increment,
    Pname varchar(40) not null,
    Classification_kids bool default false,
    Category enum("Eletrônico", "Vestimenta", "Brinquedos", "Alimentos", "Móveis"),
    evaluation float default 0,
    size varchar(10)
);

alter table product auto_increment=1;

create table payments(
	idClient int,
    idPayments int,
    TypePayment enum("Cartão", "Boleto", "Dois Cartões"),
    LimitAvailable float,
    primary key (idClient, idPayments)
);

create table orders(
	idOrder int primary key auto_increment,
    idOrderClient int, 
    OrderStatus enum("Cancelado", "Confirmado", "Em processamento") default "Em processamento",
    OrderDescription varchar(255),
    SendValue float default 10,
    PaymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

alter table orders auto_increment=1;

desc orders;

create table productStorage(
	idProdStorage int auto_increment primary key,
	StorageLocation varchar(45),
    Quantity int default 0
);

alter table productStorage auto_increment=1;

create table supplier(
	idSupplier int primary key auto_increment,
    SocialName varchar(45) not null,
    CNPJ char(15) not null,
    Contact varchar(11) not null,
    constraint unique_supplier unique (CNPJ)
);

alter table supplier auto_increment=1;

desc supplier;

create table seller(
	idSeller int primary key auto_increment,
    SocialName varchar(45),
    AbstName varchar(255),
	CNPJ char(15),
    CPF char(11),
    Location varchar(255) not null,
    Contact char(11) not null,
    constraint unique_CNPJ_seller unique (CNPJ),
    constraint unique_CPF_seller unique (CPF)
);

alter table seller auto_increment=1;

create table productSeller(
	idPSeller int,
    idProduct int,
    ProdQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

desc productSeller;

create table productOrder(
	idPOproduct int,
    idPOorder int,
    PoQuantity int default 1,
    PoStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_order foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    Location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    Quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_prodcut foreign key (idPsProduct) references product(idProduct)
);

desc productSupplier;

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';