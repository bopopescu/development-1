/*     */ package com.tms.slp20.adf.model.v1_1;
/*     */ 
/*     */ import java.util.ArrayList;
/*     */ import java.util.List;
/*     */ import javax.xml.bind.annotation.XmlAccessType;
/*     */ import javax.xml.bind.annotation.XmlAccessorType;
/*     */ import javax.xml.bind.annotation.XmlElement;
/*     */ import javax.xml.bind.annotation.XmlRootElement;
/*     */ import javax.xml.bind.annotation.XmlType;
/*     */ 
/*     */ @XmlAccessorType(XmlAccessType.FIELD)
/*     */ @XmlType(name="", propOrder={"id", "name", "service", "url", "email", "phone", "contact"})
/*     */ @XmlRootElement(name="provider")
/*     */ public class Provider
/*     */ {
/*     */   protected List<Id> id;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected Name name;
/*     */   protected String service;
/*     */   protected String url;
/*     */   protected Email email;
/*     */   protected Phone phone;
/*     */   protected Contact contact;
/*     */ 
/*     */   public List<Id> getId()
/*     */   {
/*  61 */     if (this.id == null) {
/*  62 */       this.id = new ArrayList();
/*     */     }
/*  64 */     return this.id;
/*     */   }
/*     */ 
/*     */   public void setId(List<Id> id) {
/*  68 */     this.id = id;
/*     */   }
/*     */ 
/*     */   public Name getName()
/*     */   {
/*  80 */     return this.name;
/*     */   }
/*     */ 
/*     */   public void setName(Name value)
/*     */   {
/*  92 */     this.name = value;
/*     */   }
/*     */ 
/*     */   public String getService()
/*     */   {
/* 104 */     return this.service;
/*     */   }
/*     */ 
/*     */   public void setService(String value)
/*     */   {
/* 116 */     this.service = value;
/*     */   }
/*     */ 
/*     */   public String getUrl()
/*     */   {
/* 128 */     return this.url;
/*     */   }
/*     */ 
/*     */   public void setUrl(String value)
/*     */   {
/* 140 */     this.url = value;
/*     */   }
/*     */ 
/*     */   public Email getEmail()
/*     */   {
/* 152 */     return this.email;
/*     */   }
/*     */ 
/*     */   public void setEmail(Email value)
/*     */   {
/* 164 */     this.email = value;
/*     */   }
/*     */ 
/*     */   public Phone getPhone()
/*     */   {
/* 176 */     return this.phone;
/*     */   }
/*     */ 
/*     */   public void setPhone(Phone value)
/*     */   {
/* 188 */     this.phone = value;
/*     */   }
/*     */ 
/*     */   public Contact getContact()
/*     */   {
/* 200 */     return this.contact;
/*     */   }
/*     */ 
/*     */   public void setContact(Contact value)
/*     */   {
/* 212 */     this.contact = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Provider
 * JD-Core Version:    0.6.2
 */