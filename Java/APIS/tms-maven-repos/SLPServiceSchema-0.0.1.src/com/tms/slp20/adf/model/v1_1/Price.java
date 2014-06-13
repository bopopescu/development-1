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
/*     */ @XmlRootElement(name="price")
/*     */ public class Price
/*     */ {
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String type;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(NormalizedStringAdapter.class)
/*     */   protected String currency;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String delta;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String relativeto;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(NormalizedStringAdapter.class)
/*     */   protected String source;
/*     */ 
/*     */   @XmlValue
/*     */   protected String value;
/*     */ 
/*     */   public String getType()
/*     */   {
/*  51 */     if (this.type == null) {
/*  52 */       return "quote";
/*     */     }
/*  54 */     return this.type;
/*     */   }
/*     */ 
/*     */   public void setType(String value)
/*     */   {
/*  67 */     this.type = value;
/*     */   }
/*     */ 
/*     */   public String getCurrency()
/*     */   {
/*  79 */     return this.currency;
/*     */   }
/*     */ 
/*     */   public void setCurrency(String value)
/*     */   {
/*  91 */     this.currency = value;
/*     */   }
/*     */ 
/*     */   public String getDelta()
/*     */   {
/* 103 */     return this.delta;
/*     */   }
/*     */ 
/*     */   public void setDelta(String value)
/*     */   {
/* 115 */     this.delta = value;
/*     */   }
/*     */ 
/*     */   public String getRelativeto()
/*     */   {
/* 127 */     return this.relativeto;
/*     */   }
/*     */ 
/*     */   public void setRelativeto(String value)
/*     */   {
/* 139 */     this.relativeto = value;
/*     */   }
/*     */ 
/*     */   public String getSource()
/*     */   {
/* 151 */     return this.source;
/*     */   }
/*     */ 
/*     */   public void setSource(String value)
/*     */   {
/* 163 */     this.source = value;
/*     */   }
/*     */ 
/*     */   public String getvalue()
/*     */   {
/* 175 */     return this.value;
/*     */   }
/*     */ 
/*     */   public void setvalue(String value)
/*     */   {
/* 187 */     this.value = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Price
 * JD-Core Version:    0.6.2
 */