/*    */ package com.tms.slp20.adf.model.v1_1;
/*    */ 
/*    */ import javax.xml.bind.annotation.XmlAccessType;
/*    */ import javax.xml.bind.annotation.XmlAccessorType;
/*    */ import javax.xml.bind.annotation.XmlAttribute;
/*    */ import javax.xml.bind.annotation.XmlRootElement;
/*    */ import javax.xml.bind.annotation.XmlType;
/*    */ import javax.xml.bind.annotation.XmlValue;
/*    */ import javax.xml.bind.annotation.adapters.CollapsedStringAdapter;
/*    */ import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
/*    */ 
/*    */ @XmlAccessorType(XmlAccessType.FIELD)
/*    */ @XmlType(name="", propOrder={"value"})
/*    */ @XmlRootElement(name="email")
/*    */ public class Email
/*    */ {
/*    */ 
/*    */   @XmlAttribute
/*    */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*    */   protected String preferredcontact;
/*    */ 
/*    */   @XmlValue
/*    */   protected String value;
/*    */ 
/*    */   public String getPreferredcontact()
/*    */   {
/* 38 */     if (this.preferredcontact == null) {
/* 39 */       return "0";
/*    */     }
/* 41 */     return this.preferredcontact;
/*    */   }
/*    */ 
/*    */   public void setPreferredcontact(String value)
/*    */   {
/* 54 */     this.preferredcontact = value;
/*    */   }
/*    */ 
/*    */   public String getvalue()
/*    */   {
/* 66 */     return this.value;
/*    */   }
/*    */ 
/*    */   public void setvalue(String value)
/*    */   {
/* 78 */     this.value = value;
/*    */   }
/*    */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Email
 * JD-Core Version:    0.6.2
 */