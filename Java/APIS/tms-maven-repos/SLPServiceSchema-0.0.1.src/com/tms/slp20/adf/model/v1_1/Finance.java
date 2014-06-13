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
/*     */ @XmlType(name="", propOrder={"method", "amount", "balance"})
/*     */ @XmlRootElement(name="finance")
/*     */ public class Finance
/*     */ {
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected String method;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected List<Amount> amount;
/*     */   protected Balance balance;
/*     */ 
/*     */   public String getMethod()
/*     */   {
/*  39 */     return this.method;
/*     */   }
/*     */ 
/*     */   public void setMethod(String value)
/*     */   {
/*  51 */     this.method = value;
/*     */   }
/*     */ 
/*     */   public List<Amount> getAmount()
/*     */   {
/*  77 */     if (this.amount == null) {
/*  78 */       this.amount = new ArrayList();
/*     */     }
/*  80 */     return this.amount;
/*     */   }
/*     */ 
/*     */   public Balance getBalance()
/*     */   {
/*  92 */     return this.balance;
/*     */   }
/*     */ 
/*     */   public void setBalance(Balance value)
/*     */   {
/* 104 */     this.balance = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Finance
 * JD-Core Version:    0.6.2
 */