/*     */ package com.tms.slp20.adf.model.v1_1;
/*     */ 
/*     */ import java.util.List;
/*     */ import javax.xml.bind.annotation.XmlAccessType;
/*     */ import javax.xml.bind.annotation.XmlAccessorType;
/*     */ import javax.xml.bind.annotation.XmlElements;
/*     */ import javax.xml.bind.annotation.XmlRootElement;
/*     */ import javax.xml.bind.annotation.XmlType;
/*     */ 
/*     */ @XmlAccessorType(XmlAccessType.FIELD)
/*     */ @XmlType(name="", propOrder={"id", "vendorname", "url", "contact"})
/*     */ @XmlRootElement(name="vendor")
/*     */ public class Vendor
/*     */ {
/*     */ 
/*     */   @XmlElements({@javax.xml.bind.annotation.XmlElement(name="id", required=true, type=Id.class), @javax.xml.bind.annotation.XmlElement(name="vendorname", required=true, type=Vendorname.class)})
/*     */   protected List<Id> id;
/*     */   protected Vendorname vendorname;
/*     */   protected String url;
/*     */   protected Contact contact;
/*     */ 
/*     */   public List<Id> getIds()
/*     */   {
/*  67 */     return this.id;
/*     */   }
/*     */ 
/*     */   public void setIds(List<Id> ids) {
/*  71 */     this.id = ids;
/*     */   }
/*     */ 
/*     */   public Vendorname getVendorname() {
/*  75 */     return this.vendorname;
/*     */   }
/*     */ 
/*     */   public void setVendorname(Vendorname vendorName) {
/*  79 */     this.vendorname = vendorName;
/*     */   }
/*     */ 
/*     */   public String getUrl()
/*     */   {
/*  91 */     return this.url;
/*     */   }
/*     */ 
/*     */   public void setUrl(String value)
/*     */   {
/* 103 */     this.url = value;
/*     */   }
/*     */ 
/*     */   public Contact getContact()
/*     */   {
/* 115 */     return this.contact;
/*     */   }
/*     */ 
/*     */   public void setContact(Contact value)
/*     */   {
/* 127 */     this.contact = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Vendor
 * JD-Core Version:    0.6.2
 */