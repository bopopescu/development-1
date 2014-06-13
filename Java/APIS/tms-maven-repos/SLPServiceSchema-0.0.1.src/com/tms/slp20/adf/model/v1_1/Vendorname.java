/*    */ package com.tms.slp20.adf.model.v1_1;
/*    */ 
/*    */ import javax.xml.bind.annotation.XmlAccessType;
/*    */ import javax.xml.bind.annotation.XmlAccessorType;
/*    */ import javax.xml.bind.annotation.XmlRootElement;
/*    */ import javax.xml.bind.annotation.XmlType;
/*    */ import javax.xml.bind.annotation.XmlValue;
/*    */ 
/*    */ @XmlAccessorType(XmlAccessType.FIELD)
/*    */ @XmlType(name="", propOrder={"value"})
/*    */ @XmlRootElement(name="vendorname")
/*    */ public class Vendorname
/*    */ {
/*    */ 
/*    */   @XmlValue
/*    */   protected String value;
/*    */ 
/*    */   public String getvalue()
/*    */   {
/* 32 */     return this.value;
/*    */   }
/*    */ 
/*    */   public void setvalue(String value)
/*    */   {
/* 44 */     this.value = value;
/*    */   }
/*    */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Vendorname
 * JD-Core Version:    0.6.2
 */