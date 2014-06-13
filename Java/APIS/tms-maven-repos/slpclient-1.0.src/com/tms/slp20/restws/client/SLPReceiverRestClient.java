package com.tms.slp20.restws.client;

import com.tms.slp20.adf.model.v1_1.Adf;
import com.tms.slp20.adf.model.v1_1.AdfStatus;

public abstract interface SLPReceiverRestClient
{
  public static final String ADF_STATUS_REJECTED = "REJECTED";

  public abstract AdfStatus createLead(String paramString);

  public abstract AdfStatus createLead(Adf paramAdf);
}

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/slpclient-1.0.jar
 * Qualified Name:     com.tms.slp20.restws.client.SLPReceiverRestClient
 * JD-Core Version:    0.6.2
 */