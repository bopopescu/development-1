package com.tms.slp20.restws.client;

import com.tms.slp20.adf.model.v1_1.Adf;
import com.tms.slp20.adf.model.v1_1.AdfStatus;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import org.jboss.resteasy.client.ClientResponse;
import org.springframework.stereotype.Component;

@Component
@Path("/salesLead")
public abstract interface SLPReceiverRestProxy
{
  @POST
  @Path("/lead")
  @Consumes({"application/xml"})
  @Produces({"application/xml"})
  public abstract ClientResponse<AdfStatus> acceptLeadAsXML(String paramString);

  @POST
  @Path("/lead")
  @Consumes({"application/xml"})
  @Produces({"application/xml"})
  public abstract ClientResponse<AdfStatus> postLead(Adf paramAdf);
}

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/slpclient-1.0.jar
 * Qualified Name:     com.tms.slp20.restws.client.SLPReceiverRestProxy
 * JD-Core Version:    0.6.2
 */