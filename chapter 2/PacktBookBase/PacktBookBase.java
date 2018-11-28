package com.example.demo;
import java.util.Date;
import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import org.springframework.web.client.RestTemplate;
@Named
@Path(“/”)
public class PacktBookBase 
{private static long id = 1;
@Inject
private RestTemplate restTemplate;
@GET
@Path(“book”)
@Produces(MediaType.APPLICATION_JSON)
public book submitbook(@QueryParam(“idAuthor”) long idAuthor,
@QueryParam(“idProduct”) long idProduct,
@QueryParam(“amount”) long amount) 
{
book book = new book();
Author Author = restTemplate.getForObject
(“http://localhost:9001/Author?id={id}”, Author.class,idAuthor);
Reader reader = restTemplate.getForObject
(“http://localhost:9002/reader?id={id}”, Reader.class,idProduct);
book.setAuthor(Author);
book.setReader(Reader);
book.setId(id);
book.setAmount(amount);
book.setbookDate(new Date());
id++;
return book;
}
}