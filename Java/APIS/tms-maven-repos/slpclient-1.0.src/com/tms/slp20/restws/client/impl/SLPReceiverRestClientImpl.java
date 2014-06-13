/*     */ package com.tms.slp20.restws.client.impl;
/*     */ 
/*     */ import com.tms.framework.v2.restws.RestUtil;
/*     */ import com.tms.framework.v2.restws.client.TmsRestClientImpl;
/*     */ import com.tms.slp20.adf.model.v1_1.Adf;
/*     */ import com.tms.slp20.adf.model.v1_1.AdfStatus;
/*     */ import com.tms.slp20.restws.client.SLPReceiverRestClient;
/*     */ import com.tms.slp20.restws.client.SLPReceiverRestProxy;
/*     */ import javax.ws.rs.core.Response.Status;
/*     */ import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
/*     */ import org.jboss.resteasy.client.ClientExecutor;
/*     */ import org.jboss.resteasy.client.ClientResponse;
/*     */ import org.jboss.resteasy.client.ProxyFactory;
/*     */ import org.slf4j.Logger;
/*     */ import org.slf4j.LoggerFactory;
/*     */ 
/*     */ public class SLPReceiverRestClientImpl extends TmsRestClientImpl
/*     */   implements SLPReceiverRestClient
/*     */ {
/*     */   private String slpRecieverURL;
/*  37 */   private Logger logger = LoggerFactory.getLogger(getClass());
/*     */   private ThreadSafeClientConnManager connectionManager;
/*     */   private SLPReceiverRestProxy slpReceiverRestProxy;
/*     */ 
/*     */   public SLPReceiverRestClientImpl(String slpRecieverURL)
/*     */   {
/*  49 */     this.slpRecieverURL = slpRecieverURL;
/*  50 */     init();
/*     */   }
/*     */ 
/*     */   public void init()
/*     */   {
/*     */     try
/*     */     {
/*  59 */       this.connectionManager = RestUtil.getConnectionManager(this.connectionTimeoutMs, this.socketTimeoutMs, this.maxTotalConnections, this.maxDefaultConnectionsPerRoute);
/*     */     }
/*     */     catch (Exception ex)
/*     */     {
/*  63 */       this.logger.error(ex.getMessage(), ex);
/*     */     }
/*     */   }
/*     */ 
/*     */   public AdfStatus createLead(String leadXML) {
/*  68 */     this.logger.info("Entering createLead(String leadXML).");
/*  69 */     ClientResponse response = null;
/*  70 */     ClientExecutor clientExecutor = null;
/*     */     try {
/*  72 */       this.logger.info("Calling SLPReceiverRestProxy....");
/*  73 */       clientExecutor = RestUtil.getNewClientExecutor(this.connectionManager, this.connectionTimeoutMs, this.socketTimeoutMs);
/*     */ 
/*  75 */       this.slpReceiverRestProxy = getSlpReceiverRestProxy(clientExecutor);
/*  76 */       response = this.slpReceiverRestProxy.acceptLeadAsXML(leadXML);
/*  77 */       return getAdfStatus(response);
/*     */     } catch (Exception exception) {
/*  79 */       this.logger.error("Error in calling service : ", exception);
/*  80 */       return null;
/*     */     } finally {
/*  82 */       if (response != null) {
/*  83 */         response.releaseConnection();
/*     */       }
/*  85 */       if (clientExecutor != null)
/*     */         try {
/*  87 */           clientExecutor.close();
/*     */         } catch (Exception e) {
/*  89 */           this.logger.error("Failed to close clientExecutor.", e.getMessage());
/*     */         }
/*     */     }
/*     */   }
/*     */ 
/*     */   public AdfStatus createLead(Adf adf)
/*     */   {
/*  97 */     this.logger.info("Entering createLead(Adf).");
/*  98 */     ClientResponse response = null;
/*  99 */     ClientExecutor clientExecutor = null;
/*     */     try {
/* 101 */       this.logger.info("Calling SLPReceiverRestProxy....");
/* 102 */       clientExecutor = RestUtil.getNewClientExecutor(this.connectionManager, this.connectionTimeoutMs, this.socketTimeoutMs);
/*     */ 
/* 104 */       this.slpReceiverRestProxy = getSlpReceiverRestProxy(clientExecutor);
/* 105 */       response = this.slpReceiverRestProxy.postLead(adf);
/* 106 */       return getAdfStatus(response);
/*     */     } catch (Exception exception) {
/* 108 */       this.logger.error("Error in calling service : ", exception);
/* 109 */       return null;
/*     */     } finally {
/* 111 */       if (response != null) {
/* 112 */         response.releaseConnection();
/*     */       }
/* 114 */       if (clientExecutor != null)
/*     */         try {
/* 116 */           clientExecutor.close();
/*     */         } catch (Exception e) {
/* 118 */           this.logger.error("Failed to close clientExecutor.", e.getMessage());
/*     */         }
/*     */     }
/*     */   }
/*     */ 
/*     */   private AdfStatus getAdfStatus(ClientResponse<AdfStatus> response)
/*     */   {
/* 126 */     AdfStatus adfStatus = null;
/* 127 */     this.logger.info("Entering SLPReceiverRestClientImpl.getAdfStatus method ");
/* 128 */     if (response != null) {
/* 129 */       if ((response.getStatus() == Response.Status.OK.getStatusCode()) && (response.getEntity(AdfStatus.class) != null))
/*     */       {
/* 131 */         adfStatus = (AdfStatus)response.getEntity(AdfStatus.class);
/*     */       }
/*     */       else {
/* 134 */         this.logger.info("Error communicating with service. Status: {}", Integer.valueOf(response.getStatus()));
/*     */ 
/* 136 */         throw new RuntimeException("Error communicating with service. Status: " + response.getStatus() + " " + response.getResponseStatus().getReasonPhrase());
/*     */       }
/*     */ 
/*     */     }
/*     */     else
/*     */     {
/* 144 */       this.logger.info("Dealer Pool response is null.");
/*     */     }
/* 146 */     return adfStatus;
/*     */   }
/*     */ 
/*     */   private SLPReceiverRestProxy getSlpReceiverRestProxy(ClientExecutor clientExecutor) {
/* 150 */     return (SLPReceiverRestProxy)ProxyFactory.create(SLPReceiverRestProxy.class, this.slpRecieverURL, clientExecutor);
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/slpclient-1.0.jar
 * Qualified Name:     com.tms.slp20.restws.client.impl.SLPReceiverRestClientImpl
 * JD-Core Version:    0.6.2
 */