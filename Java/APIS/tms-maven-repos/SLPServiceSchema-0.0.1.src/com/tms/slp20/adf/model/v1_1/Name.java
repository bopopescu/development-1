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
/*     */ @XmlRootElement(name="name")
/*     */ public class Name
/*     */ {
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String part;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String type;
/*     */ 
/*     */   @XmlValue
/*     */   protected String value;
/*     */ 
/*     */   public String getPart()
/*     */   {
/*  41 */     if (this.part == null) {
/*  42 */       return "full";
/*     */     }
/*  44 */     return this.part;
/*     */   }
/*     */ 
/*     */   public void setPart(String value)
/*     */   {
/*  57 */     this.part = value;
/*     */   }
/*     */ 
/*     */   public String getType()
/*     */   {
/*  69 */     if (this.type == null) {
/*  70 */       return "individual";
/*     */     }
/*  72 */     return this.type;
/*     */   }
/*     */ 
/*     */   public void setType(String value)
/*     */   {
/*  85 */     this.type = value;
/*     */   }
/*     */ 
/*     */   public String getvalue()
/*     */   {
/*  97 */     return this.value;
/*     */   }
/*     */ 
/*     */   public void setvalue(String value)
/*     */   {
/* 109 */     this.value = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Name
 * JD-Core Version:    0.6.2
 */