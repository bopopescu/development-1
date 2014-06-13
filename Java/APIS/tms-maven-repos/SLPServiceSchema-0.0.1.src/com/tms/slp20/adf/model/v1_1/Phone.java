/*     */ package com.tms.slp20.adf.model.v1_1;
/*     */ 
/*     */ import javax.xml.bind.annotation.XmlAccessType;
/*     */ import javax.xml.bind.annotation.XmlAccessorType;
/*     */ import javax.xml.bind.annotation.XmlAttribute;
/*     */ import javax.xml.bind.annotation.XmlRootElement;
/*     */ import javax.xml.bind.annotation.XmlType;
/*     */ import javax.xml.bind.annotation.XmlValue;
/*     */ import javax.xml.bind.annotation.adapters.CollapsedStringAdapter;
/*     */ import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
/*     */ 
/*     */ @XmlAccessorType(XmlAccessType.FIELD)
/*     */ @XmlType(name="", propOrder={"value"})
/*     */ @XmlRootElement(name="phone")
/*     */ public class Phone
/*     */ {
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String type;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String time;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String preferredcontact;
/*     */ 
/*     */   @XmlValue
/*     */   protected String value;
/*     */ 
/*     */   public String getType()
/*     */   {
/*  44 */     if (this.type == null) {
/*  45 */       return "voice";
/*     */     }
/*  47 */     return this.type;
/*     */   }
/*     */ 
/*     */   public void setType(String value)
/*     */   {
/*  60 */     this.type = value;
/*     */   }
/*     */ 
/*     */   public String getTime()
/*     */   {
/*  72 */     if (this.time == null) {
/*  73 */       return "nopreference";
/*     */     }
/*  75 */     return this.time;
/*     */   }
/*     */ 
/*     */   public void setTime(String value)
/*     */   {
/*  88 */     this.time = value;
/*     */   }
/*     */ 
/*     */   public String getPreferredcontact()
/*     */   {
/* 100 */     if (this.preferredcontact == null) {
/* 101 */       return "0";
/*     */     }
/* 103 */     return this.preferredcontact;
/*     */   }
/*     */ 
/*     */   public void setPreferredcontact(String value)
/*     */   {
/* 116 */     this.preferredcontact = value;
/*     */   }
/*     */ 
/*     */   public String getvalue()
/*     */   {
/* 128 */     return this.value;
/*     */   }
/*     */ 
/*     */   public void setvalue(String value)
/*     */   {
/* 140 */     this.value = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Phone
 * JD-Core Version:    0.6.2
 */