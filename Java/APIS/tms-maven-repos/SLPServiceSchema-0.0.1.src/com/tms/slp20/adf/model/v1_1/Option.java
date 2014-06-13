/*     */ package com.tms.slp20.adf.model.v1_1;
/*     */ 
/*     */ import javax.xml.bind.annotation.XmlAccessType;
/*     */ import javax.xml.bind.annotation.XmlAccessorType;
/*     */ import javax.xml.bind.annotation.XmlElement;
/*     */ import javax.xml.bind.annotation.XmlRootElement;
/*     */ import javax.xml.bind.annotation.XmlType;
/*     */ 
/*     */ @XmlAccessorType(XmlAccessType.FIELD)
/*     */ @XmlType(name="", propOrder={"optionname", "manufacturercode", "stock", "weighting", "price"})
/*     */ @XmlRootElement(name="option")
/*     */ public class Option
/*     */ {
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected String optionname;
/*     */   protected String manufacturercode;
/*     */   protected String stock;
/*     */   protected String weighting;
/*     */   protected Price price;
/*     */ 
/*     */   public String getOptionname()
/*     */   {
/*  40 */     return this.optionname;
/*     */   }
/*     */ 
/*     */   public void setOptionname(String value)
/*     */   {
/*  52 */     this.optionname = value;
/*     */   }
/*     */ 
/*     */   public String getManufacturercode()
/*     */   {
/*  64 */     return this.manufacturercode;
/*     */   }
/*     */ 
/*     */   public void setManufacturercode(String value)
/*     */   {
/*  76 */     this.manufacturercode = value;
/*     */   }
/*     */ 
/*     */   public String getStock()
/*     */   {
/*  88 */     return this.stock;
/*     */   }
/*     */ 
/*     */   public void setStock(String value)
/*     */   {
/* 100 */     this.stock = value;
/*     */   }
/*     */ 
/*     */   public String getWeighting()
/*     */   {
/* 112 */     return this.weighting;
/*     */   }
/*     */ 
/*     */   public void setWeighting(String value)
/*     */   {
/* 124 */     this.weighting = value;
/*     */   }
/*     */ 
/*     */   public Price getPrice()
/*     */   {
/* 136 */     return this.price;
/*     */   }
/*     */ 
/*     */   public void setPrice(Price value)
/*     */   {
/* 148 */     this.price = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Option
 * JD-Core Version:    0.6.2
 */