/*     */ package com.tms.slp20.adf.model.v1_1;
/*     */ 
/*     */ import javax.xml.bind.annotation.XmlAccessType;
/*     */ import javax.xml.bind.annotation.XmlAccessorType;
/*     */ import javax.xml.bind.annotation.XmlAttribute;
/*     */ import javax.xml.bind.annotation.XmlRootElement;
/*     */ import javax.xml.bind.annotation.XmlType;
/*     */ import javax.xml.bind.annotation.XmlValue;
/*     */ import javax.xml.bind.annotation.adapters.CollapsedStringAdapter;
/*     */ import javax.xml.bind.annotation.adapters.NormalizedStringAdapter;
/*     */ import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
/*     */ 
/*     */ @XmlAccessorType(XmlAccessType.FIELD)
/*     */ @XmlType(name="", propOrder={"value"})
/*     */ @XmlRootElement(name="amount")
/*     */ public class Amount
/*     */ {
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String type;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String limit;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(NormalizedStringAdapter.class)
/*     */   protected String currency;
/*     */ 
/*     */   @XmlValue
/*     */   protected String value;
/*     */ 
/*     */   public String getType()
/*     */   {
/*  45 */     if (this.type == null) {
/*  46 */       return "total";
/*     */     }
/*  48 */     return this.type;
/*     */   }
/*     */ 
/*     */   public void setType(String value)
/*     */   {
/*  61 */     this.type = value;
/*     */   }
/*     */ 
/*     */   public String getLimit()
/*     */   {
/*  73 */     if (this.limit == null) {
/*  74 */       return "maximum";
/*     */     }
/*  76 */     return this.limit;
/*     */   }
/*     */ 
/*     */   public void setLimit(String value)
/*     */   {
/*  89 */     this.limit = value;
/*     */   }
/*     */ 
/*     */   public String getCurrency()
/*     */   {
/* 101 */     return this.currency;
/*     */   }
/*     */ 
/*     */   public void setCurrency(String value)
/*     */   {
/* 113 */     this.currency = value;
/*     */   }
/*     */ 
/*     */   public String getvalue()
/*     */   {
/* 125 */     return this.value;
/*     */   }
/*     */ 
/*     */   public void setvalue(String value)
/*     */   {
/* 137 */     this.value = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Amount
 * JD-Core Version:    0.6.2
 */