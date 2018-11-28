package com.example.demo;
import java.util.ArrayList;
import java.util.List;
import javax.inject.Named;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
@Named
@Path(“/”)
public class PacktAuthorBase 
{
private static List<Author> clients = new ArrayList<Author>();
static 
{
Author Author1 = new Author();
Author1.setId(1);
Author1.setName(“PackAuthor 1”);
Author1.setEmail(“Author1@hotmail.com”);
Author Author2 = new Author();
Author2.setId(2);
Author2.setName(“PackAuthor 2”);
Author2.setEmail(“Author2@hotmail.com”);
clients.add(Author1);
clients.add(Author2);
}
@GET
@Produces(MediaType.APPLICATION_JSON)
public List<Author> getClientes() 
{
return clients;
}

@GET
@Path(“Author”)
@Produces(MediaType.APPLICATION_JSON)
public Author getCliente(@QueryParam(“id”) long id) 
{
Author cli = null;
for (Author a : clients)
 {
if (a.getId() == id)
cli = a;
}
return cli;
}
}