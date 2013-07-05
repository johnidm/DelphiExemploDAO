CREATE TABLE clientes (
   id_cliente	 		INTEGER NOT NULL
   
  
  
  ,nm_cliente			VARCHAR (  60) NOT NULL
  
	  
  ,dt_cadastro			TIMESTAMP NOT NULL   
 
);

ALTER TABLE clientes ADD CONSTRAINT id_cliente_clientes_pk PRIMARY KEY (id_cliente);

CREATE GENERATOR id_cliente_clientes_gn;
SET GENERATOR id_cliente_clientes_gn TO 0;