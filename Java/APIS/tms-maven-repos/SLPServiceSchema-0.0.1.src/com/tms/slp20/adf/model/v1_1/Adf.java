/*    */ package com.tms.slp20.adf.model.v1_1;
/*    */ 
/*    */ import java.util.ArrayList;
/*    */ import java.util.List;
/*    */ import javax.xml.bind.annotation.XmlAccessType;
/*    */ import javax.xml.bind.annotation.XmlAccessorType;
/*    */ import javax.xml.bind.annotation.XmlElement;
/*    */ import javax.xml.bind.annotation.XmlRootElement;
/*    */ import javax.xml.bind.annotation.XmlType;
/*    */ 
/*    */ @XmlAccessorType(XmlAccessType.FIELD)
/*    */ @XmlType(name="", propOrder={"prospect"})
/*    */ @XmlRootElement(name="adf")
/*    */ public class Adf
/*    */ {
/*    */ 
/*    */   @XmlElement(required=true)
/*    */   protected List<Prospect> prospect;
/*    */ 
/*    */   public List<Prospect> getProspect()
/*    */   {
/* 56 */     if (this.prospect == null) {
/* 57 */       this.prospect = new ArrayList();
/*    */     }
/* 59 */     return this.prospect;
/*    */   }
/*    */ 
/*    */   public void setProspect(List<Prospect> prospect) {
/* 63 */     this.prospect = prospect;
/*    */   }
/*    */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Adf
 * JD-Core Version:    0.6.2
 */