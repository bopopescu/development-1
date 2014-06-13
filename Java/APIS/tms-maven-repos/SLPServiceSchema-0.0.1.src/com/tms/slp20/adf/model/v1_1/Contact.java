/*     */ package com.tms.slp20.adf.model.v1_1;
/*     */ 
/*     */ import java.util.ArrayList;
/*     */ import java.util.List;
/*     */ import javax.xml.bind.annotation.XmlAccessType;
/*     */ import javax.xml.bind.annotation.XmlAccessorType;
/*     */ import javax.xml.bind.annotation.XmlElement;
/*     */ import javax.xml.bind.annotation.XmlElements;
/*     */ import javax.xml.bind.annotation.XmlRootElement;
/*     */ import javax.xml.bind.annotation.XmlType;
/*     */ 
/*     */ @XmlAccessorType(XmlAccessType.FIELD)
/*     */ @XmlType(name="", propOrder={"name", "email", "phone", "address"})
/*     */ @XmlRootElement(name="contact")
/*     */ public class Contact
/*     */ {
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected List<Name> name;
/*     */ 
/*     */   @XmlElements({@XmlElement(name="email", required=false, type=Email.class), @XmlElement(name="phone", required=true, type=Phone.class)})
/*     */   protected List<Email> email;
/*     */   protected List<Phone> phone;
/*     */   protected Address address;
/*     */ 
/*     */   public void setName(List<Name> name)
/*     */   {
/*  27 */     this.name = name;
/*     */   }
/*     */ 
/*     */   public List<Name> getName()
/*     */   {
/*  67 */     if (this.name == null) {
/*  68 */       this.name = new ArrayList();
/*     */     }
/*  70 */     return this.name;
/*     */   }
/*     */ 
/*     */   public Address getAddress()
/*     */   {
/* 112 */     return this.address;
/*     */   }
/*     */ 
/*     */   public List<Email> getEmail() {
/* 116 */     return this.email;
/*     */   }
/*     */ 
/*     */   public void setEmail(List<Email> email) {
/* 120 */     this.email = email;
/*     */   }
/*     */ 
/*     */   public List<Phone> getPhone() {
/* 124 */     return this.phone;
/*     */   }
/*     */ 
/*     */   public void setPhone(List<Phone> phone) {
/* 128 */     this.phone = phone;
/*     */   }
/*     */ 
/*     */   public void setAddress(Address value)
/*     */   {
/* 140 */     this.address = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Contact
 * JD-Core Version:    0.6.2
 */