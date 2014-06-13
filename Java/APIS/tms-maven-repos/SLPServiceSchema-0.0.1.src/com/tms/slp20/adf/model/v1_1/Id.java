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
/*     */ @XmlRootElement(name="id")
/*     */ public class Id
/*     */ {
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(NormalizedStringAdapter.class)
/*     */   protected String sequence;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(NormalizedStringAdapter.class)
/*     */   protected String source;
/*     */ 
/*     */   @XmlValue
/*     */   protected String value;
/*     */ 
/*     */   public String getSequence()
/*     */   {
/*  41 */     return this.sequence;
/*     */   }
/*     */ 
/*     */   public void setSequence(String value)
/*     */   {
/*  53 */     this.sequence = value;
/*     */   }
/*     */ 
/*     */   public String getSource()
/*     */   {
/*  65 */     return this.source;
/*     */   }
/*     */ 
/*     */   public void setSource(String value)
/*     */   {
/*  77 */     this.source = value;
/*     */   }
/*     */ 
/*     */   public String getvalue()
/*     */   {
/*  89 */     return this.value;
/*     */   }
/*     */ 
/*     */   public void setvalue(String value)
/*     */   {
/* 101 */     this.value = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Id
 * JD-Core Version:    0.6.2
 */