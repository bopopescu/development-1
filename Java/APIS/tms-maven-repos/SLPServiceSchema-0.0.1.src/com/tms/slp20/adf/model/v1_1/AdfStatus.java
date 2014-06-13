/*    */ package com.tms.slp20.adf.model.v1_1;
/*    */ 
/*    */ import javax.xml.bind.annotation.XmlAccessType;
/*    */ import javax.xml.bind.annotation.XmlAccessorType;
/*    */ import javax.xml.bind.annotation.XmlElement;
/*    */ import javax.xml.bind.annotation.XmlRootElement;
/*    */ 
/*    */ @XmlAccessorType(XmlAccessType.FIELD)
/*    */ @XmlRootElement(name="adfstatus")
/*    */ public class AdfStatus
/*    */ {
/*    */ 
/*    */   @XmlElement(required=true)
/*    */   private String responseCode;
/*    */ 
/*    */   @XmlElement(required=true)
/*    */   private String responseDetails;
/*    */ 
/*    */   public String getResponseCode()
/*    */   {
/* 42 */     return this.responseCode;
/*    */   }
/*    */ 
/*    */   public void setResponseCode(String responseCode)
/*    */   {
/* 49 */     this.responseCode = responseCode;
/*    */   }
/*    */ 
/*    */   public String getResponseDetails()
/*    */   {
/* 56 */     return this.responseDetails;
/*    */   }
/*    */ 
/*    */   public void setResponseDetails(String responseDetails)
/*    */   {
/* 63 */     this.responseDetails = responseDetails;
/*    */   }
/*    */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.AdfStatus
 * JD-Core Version:    0.6.2
 */