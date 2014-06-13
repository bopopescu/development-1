/*     */ package com.tms.slp20.adf.model.v1_1;
/*     */ 
/*     */ import java.util.ArrayList;
/*     */ import java.util.List;
/*     */ import javax.xml.bind.annotation.XmlAccessType;
/*     */ import javax.xml.bind.annotation.XmlAccessorType;
/*     */ import javax.xml.bind.annotation.XmlElement;
/*     */ import javax.xml.bind.annotation.XmlRootElement;
/*     */ import javax.xml.bind.annotation.XmlType;
/*     */ 
/*     */ @XmlAccessorType(XmlAccessType.FIELD)
/*     */ @XmlType(name="", propOrder={"contact", "id", "timeframe", "comments"})
/*     */ @XmlRootElement(name="customer")
/*     */ public class Customer
/*     */ {
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected Contact contact;
/*     */   protected List<Id> id;
/*     */   protected Timeframe timeframe;
/*     */   protected String comments;
/*     */ 
/*     */   public Contact getContact()
/*     */   {
/*  40 */     return this.contact;
/*     */   }
/*     */ 
/*     */   public void setContact(Contact value)
/*     */   {
/*  52 */     this.contact = value;
/*     */   }
/*     */ 
/*     */   public List<Id> getId()
/*     */   {
/*  78 */     if (this.id == null) {
/*  79 */       this.id = new ArrayList();
/*     */     }
/*  81 */     return this.id;
/*     */   }
/*     */ 
/*     */   public Timeframe getTimeframe()
/*     */   {
/*  93 */     return this.timeframe;
/*     */   }
/*     */ 
/*     */   public void setTimeframe(Timeframe value)
/*     */   {
/* 105 */     this.timeframe = value;
/*     */   }
/*     */ 
/*     */   public String getComments()
/*     */   {
/* 117 */     return this.comments;
/*     */   }
/*     */ 
/*     */   public void setComments(String value)
/*     */   {
/* 129 */     this.comments = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Customer
 * JD-Core Version:    0.6.2
 */