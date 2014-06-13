/*    */ package com.tms.slp20.adf.model.v1_1;
/*    */ 
/*    */ import javax.xml.bind.annotation.XmlAccessType;
/*    */ import javax.xml.bind.annotation.XmlAccessorType;
/*    */ import javax.xml.bind.annotation.XmlAttribute;
/*    */ import javax.xml.bind.annotation.XmlRootElement;
/*    */ import javax.xml.bind.annotation.XmlType;
/*    */ import javax.xml.bind.annotation.XmlValue;
/*    */ import javax.xml.bind.annotation.adapters.NormalizedStringAdapter;
/*    */ import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
/*    */ 
/*    */ @XmlAccessorType(XmlAccessType.FIELD)
/*    */ @XmlType(name="", propOrder={"value"})
/*    */ @XmlRootElement(name="street")
/*    */ public class Street
/*    */ {
/*    */ 
/*    */   @XmlAttribute
/*    */   @XmlJavaTypeAdapter(NormalizedStringAdapter.class)
/*    */   protected String line;
/*    */ 
/*    */   @XmlValue
/*    */   protected String value;
/*    */ 
/*    */   public String getLine()
/*    */   {
/* 38 */     return this.line;
/*    */   }
/*    */ 
/*    */   public void setLine(String value)
/*    */   {
/* 50 */     this.line = value;
/*    */   }
/*    */ 
/*    */   public String getvalue()
/*    */   {
/* 62 */     return this.value;
/*    */   }
/*    */ 
/*    */   public void setvalue(String value)
/*    */   {
/* 74 */     this.value = value;
/*    */   }
/*    */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Street
 * JD-Core Version:    0.6.2
 */