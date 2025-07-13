/*************************************************************************
* ADOBE CONFIDENTIAL
* ___________________
*
*  Copyright 2015 Adobe Systems Incorporated
*  All Rights Reserved.
*
* NOTICE:  All information contained herein is, and remains
* the property of Adobe Systems Incorporated and its suppliers,
* if any.  The intellectual and technical concepts contained
* herein are proprietary to Adobe Systems Incorporated and its
* suppliers and are protected by all applicable intellectual property laws,
* including trade secret and or copyright laws.
* Dissemination of this information or reproduction of this material
* is strictly forbidden unless prior written permission is obtained
* from Adobe Systems Incorporated.
**************************************************************************/
import expressFteUtils from"../express-fte-utils.js";class ExpressContextualFTE{CSS_CLASSNAME_PREFIX="ae1eed7c";constructor(t,e,s,i){this.initPromise=this.init(),this.touchpoint=t,this.ctaButtonElement=e,this.fteStrings=s,this.updateWhatsappExpressStateCallback=i,this.handleResize=this.handleResize.bind(this),this.handleDocumentClick=this.handleDocumentClick.bind(this)}async init(){await expressFteUtils.addFontToDocument(),this.htmlDataPromise=fetch(chrome.runtime.getURL("resources/express/expressContextualFTE.html")).then((t=>t.text())).then((t=>{this.htmlData=t}))}async render(){await this.initPromise;if(document.getElementById("express-contextual-fte"))return;await this.htmlDataPromise,this.fte=document.createElement("div"),this.fte.id="express-contextual-fte",this.fte.innerHTML=this.htmlData,this.positionFTE(),this.addFteStrings(),this.addDismissListener(),this.windowResizeListener(),document.body.appendChild(this.fte);const t=new URL(window.location.href).hostname;expressFteUtils.sendAnalyticsEvent([["DCBrowserExt:Express:FTE:Shown",{domain:t,expressTouchpoint:this.touchpoint}]]),this.updateWhatsappExpressStateCallback()}positionFTE(){const t=this.ctaButtonElement.getBoundingClientRect(),e=this.fte.getElementsByClassName(`${this.CSS_CLASSNAME_PREFIX}-express-contextual-fte`)?.[0];e&&(e.style.top=t.top+this.ctaButtonElement.offsetHeight+window.scrollY+"px",e.style.left=t.left+this.ctaButtonElement.offsetWidth/2+window.scrollX+"px",e.style.transform="translate(-50%, 0%)")}addFteStrings(){const t=this.fte.getElementsByClassName(`${this.CSS_CLASSNAME_PREFIX}-express-contextual-fte-title`)?.[0],e=this.fte.getElementsByClassName(`${this.CSS_CLASSNAME_PREFIX}-express-contextual-fte-desc`)?.[0],s=this.fte.getElementsByClassName(`${this.CSS_CLASSNAME_PREFIX}-express-contextual-fte-cta`)?.[0];t&&(t.textContent=this.fteStrings?.fteTitle),e&&(e.textContent=this.fteStrings?.fteDescription),s&&(s.textContent=this.fteStrings?.fteCtaLabel)}addDismissListener(){const t=this.fte.getElementsByClassName(`${this.CSS_CLASSNAME_PREFIX}-express-contextual-fte-cta`)?.[0];t&&(t.onclick=()=>{this.remove()}),document.addEventListener("click",this.handleDocumentClick,{once:!0})}windowResizeListener(){window.addEventListener("resize",this.handleResize)}handleDocumentClick(){this.remove()}handleResize(){this.positionFTE()}remove(){this.fte?.remove(),document.removeEventListener("click",this.handleDocumentClick),window.removeEventListener("resize",this.handleResize)}}export default ExpressContextualFTE;