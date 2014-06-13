/*     */ package com.tms.slp20.adf.model.v1_1;
/*     */ 
/*     */ import javax.xml.bind.annotation.XmlAccessType;
/*     */ import javax.xml.bind.annotation.XmlAccessorType;
/*     */ import javax.xml.bind.annotation.XmlAttribute;
/*     */ import javax.xml.bind.annotation.XmlRootElement;
/*     */ import javax.xml.bind.annotation.XmlType;
/*     */ import javax.xml.bind.annotation.XmlValue;
/*     */ import javax.xml.bind.annotation.adapters.NormalizedStringAdapter;
/*     */ import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
/*     */ 
/*     */ @XmlAccessorType(XmlAccessType.FIELD)
/*     */ @XmlType(name="", propOrder={"value"})
/*     */ @XmlRootElement(name="imagetag")
/*     */ public class Imagetag
/*     */ {
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(NormalizedStringAdapter.class)
/*     */   protected String width;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(NormalizedStringAdapter.class)
/*     */   protected String height;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(NormalizedStringAdapter.class)
/*     */   protected String alttext;
/*     */ 
/*     */   @XmlValue
/*     */   protected String value;
/*     */ 
/*     */   public String getWidth()
/*     */   {
/*  44 */     return this.width;
/*     */   }
/*     */ 
/*     */   public void setWidth(String value)
/*     */   {
/*  56 */     this.width = value;
/*     */   }
/*     */ 
/*     */   public String getHeight()
/*     */   {
/*  68 */     return this.height;
/*     */   }
/*     */ 
/*     */   public void setHeight(String value)
/*     */   {
/*  80 */     this.height = value;
/*     */   }
/*     */ 
/*     */   public String getAlttext()
/*     */   {
/*  92 */     return this.alttext;
/*     */   }
/*     */ 
/*     */   public void setAlttext(String value)
/*     */   {
/* 104 */     this.alttext = value;
/*     */   }
/*     */ 
/*     */   public String getvalue()
/*     */   {
/* 116 */     return this.value;
/*     */   }
/*     */ 
/*     */   public void setvalue(String value)
/*     */   {
/* 128 */     this.value = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Imagetag
 * JD-Core Version:    0.6.2
 */