/*     */ package com.tms.slp20.adf.model.v1_1;
/*     */ 
/*     */ import javax.xml.bind.annotation.XmlAccessType;
/*     */ import javax.xml.bind.annotation.XmlAccessorType;
/*     */ import javax.xml.bind.annotation.XmlElement;
/*     */ import javax.xml.bind.annotation.XmlRootElement;
/*     */ import javax.xml.bind.annotation.XmlType;
/*     */ 
/*     */ @XmlAccessorType(XmlAccessType.FIELD)
/*     */ @XmlType(name="", propOrder={"interiorcolor", "exteriorcolor", "preference"})
/*     */ @XmlRootElement(name="colorcombination")
/*     */ public class Colorcombination
/*     */ {
/*     */ 
/*     */   @XmlElement
/*     */   protected Interiorcolor interiorcolor;
/*     */ 
/*     */   @XmlElement
/*     */   protected Exteriorcolor exteriorcolor;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected String preference;
/*     */ 
/*     */   public String getPreference()
/*     */   {
/*  74 */     return this.preference;
/*     */   }
/*     */ 
/*     */   public void setPreference(String value)
/*     */   {
/*  86 */     this.preference = value;
/*     */   }
/*     */ 
/*     */   public Interiorcolor getInteriorcolor() {
/*  90 */     return this.interiorcolor;
/*     */   }
/*     */ 
/*     */   public void setInteriorcolor(Interiorcolor interiorcolor) {
/*  94 */     this.interiorcolor = interiorcolor;
/*     */   }
/*     */ 
/*     */   public Exteriorcolor getExteriorcolor() {
/*  98 */     return this.exteriorcolor;
/*     */   }
/*     */ 
/*     */   public void setExteriorcolor(Exteriorcolor exteriorcolor) {
/* 102 */     this.exteriorcolor = exteriorcolor;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Colorcombination
 * JD-Core Version:    0.6.2
 */