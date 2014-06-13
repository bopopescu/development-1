/*    */ package com.tms.slp20.adf.model.v1_1;
/*    */ 
/*    */ import java.util.ArrayList;
/*    */ import java.util.List;
/*    */ import javax.xml.bind.annotation.XmlAccessType;
/*    */ import javax.xml.bind.annotation.XmlAccessorType;
/*    */ import javax.xml.bind.annotation.XmlElements;
/*    */ import javax.xml.bind.annotation.XmlRootElement;
/*    */ import javax.xml.bind.annotation.XmlType;
/*    */ 
/*    */ @XmlAccessorType(XmlAccessType.FIELD)
/*    */ @XmlType(name="", propOrder={"descriptionOrEarliestdateOrLatestdate"})
/*    */ @XmlRootElement(name="timeframe")
/*    */ public class Timeframe
/*    */ {
/*    */ 
/*    */   @XmlElements({@javax.xml.bind.annotation.XmlElement(name="description", required=true, type=Description.class), @javax.xml.bind.annotation.XmlElement(name="earliestdate", required=true, type=Earliestdate.class), @javax.xml.bind.annotation.XmlElement(name="latestdate", required=true, type=Latestdate.class)})
/*    */   protected List<Object> descriptionOrEarliestdateOrLatestdate;
/*    */ 
/*    */   public List<Object> getDescriptionOrEarliestdateOrLatestdate()
/*    */   {
/* 55 */     if (this.descriptionOrEarliestdateOrLatestdate == null) {
/* 56 */       this.descriptionOrEarliestdateOrLatestdate = new ArrayList();
/*    */     }
/* 58 */     return this.descriptionOrEarliestdateOrLatestdate;
/*    */   }
/*    */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Timeframe
 * JD-Core Version:    0.6.2
 */