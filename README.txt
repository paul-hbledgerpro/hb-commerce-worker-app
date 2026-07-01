HB Commerce Cloudflare Worker App v217 - Report title centering and PDF download fix

HB Commerce Cloudflare Worker App v212 - no-blue-bleed PDF divider fix

HB Commerce Cloudflare Worker App v209 - Paid invoice PDF button and mobile print fix

Changes in v209:
- Paid invoice emails now make the View Paid Invoice button open the generated one-page PDF directly.
- Paid invoice emails also keep a separate View Online Copy button for the responsive webpage view.
- Unpaid invoice emails still keep Pay Secure Online, responsive View Invoice, and Open 1-Page PDF actions.
- The public review page no longer uses the browser window.print() action for the main PDF button. It opens the server-generated one-page PDF route directly.
- Download PDF now uses ?download=1 so the PDF can be downloaded instead of only displayed inline.
- Added print-safe CSS so browser/native print from the public review page does not create a tiny invoice plus a blank second page.
- PDF email attachments remain disabled by default. Use EMAIL_ATTACH_DOCUMENT_PDF=1 only if you intentionally want attachments again.
- No database migration is required.

HB Commerce Cloudflare Worker App v208 - Responsive invoice view and no default PDF email attachments

Changes in v208:
- Customer quote/invoice emails no longer attach PDF files by default.
- Email body keeps the main action buttons, including View Invoice / View Paid Invoice and Download PDF.
- View Invoice / View Paid Invoice public pages now use responsive phone, tablet, and desktop layouts.
- Phone layout removes horizontal dragging by converting the line-item table into readable mobile cards.
- PDF attachment can be re-enabled later only by setting EMAIL_ATTACH_DOCUMENT_PDF=1 as a Worker variable/secret.

HB Commerce Worker App v206 - Website Final Notice Modal + PDF Quote/Invoice Emails

Changes in v206:
- Checkout Place Order final-sale notice is enforced as an in-page website modal with an OK button, not a browser alert.
- Admin-created quotes and invoices now include Download PDF actions using /admin/document.pdf.
- Customer review links now include a direct Download PDF button using /review/{id}/{token}.pdf.
- Save and Email, Email Client PDF, payment-link emails, and reminder emails now attach a generated PDF copy of the quote/invoice.
- Quote/invoice email HTML now uses the newer HB Commerce navy/orange/green design with Bill To, Ship To, totals, action buttons, and PDF download link.
- PDF output uses the newer branded layout with separate Bill To and Ship To sections, shipping, tax, totals, payment information, and multi-page line item support.
- No database migration is required.

HB Commerce Worker App v203 - Auto ZIP, Auto Shipping, FedEx Rate Fix, Checkout-Style Admin Theme

Changes in v203:
- Create Quote/Create Invoice now auto-fills billing city/state when a 5-digit billing ZIP is entered.
- Shipping city/state also auto-fills from shipping ZIP.
- The Shipping Address Same As Billing checkbox is no longer checked by default on new/cloned manual documents.
- UPS/FedEx shipping rates auto-calculate when carrier, ZIP, address, package weight, or line items change. The manual Calculate Shipping button was removed.
- FedEx rating was hardened: the Worker now sends a fuller Rate API payload, tries FedEx Ground Home Delivery first for residential destinations, falls back to FedEx Ground, parses FedEx charge responses more robustly, and shows better diagnostics on /admin/fedex-test.
- Create Quote/Create Invoice admin pages now use a darker checkout-style navy/green/orange theme with readable field colors.

HB Commerce Solutions Cloudflare Worker App
==========================================

This package replaces GoDaddy hosting and Google Apps Script with Cloudflare Workers + D1.


V202 UPDATE - BILLING / SHIPPING / MANUAL SHIPPING CALCULATOR
------------------------------------------------------------
- Manual Quote and Invoice creation now has separate Billing Address and Shipping Address sections.
- Added a checkbox: Shipping address same as billing address. When selected, the shipping fields auto-fill from billing fields.
- Destination tax lookup now uses the Shipping Address.
- Added Shipping Method / Carrier, optional Package Weight, Shipping Cost, and Calculate Shipping controls to manual quote/invoice creation.
- UPS Ground and FedEx Ground calculation uses the existing /api/shipping/rate endpoint and adds the returned amount to the quote/invoice total as non-taxable shipping.
- Existing older documents still work because legacy street/city/state/zip fields are mapped to the shipping destination.
- No database migration is required because document detail fields are stored in data_json.

WHAT IT INCLUDES
----------------
- Public website:
  - Home
  - Services with dropdown
  - Payment Processing
  - POS Software for Retail
  - Security Camera Systems
  - About Us
  - Contact Us
- Admin portal:
  - First-time setup
  - Login/logout
  - Create Estimate, Quote, Invoice
  - Internal cost price and markup
  - Line-item discount
  - Customer secure review links
  - Quote/Estimate approval only
  - Invoice view-only
  - Invoice paid/unpaid tracking
  - Email secure customer link using Resend
  - Browser Print / Save PDF

DEPLOYMENT SUMMARY
------------------
1. Unzip this folder.
2. Open Command Prompt inside this folder.
3. Run:
   npx wrangler login
4. Create D1 database:
   npx wrangler d1 create hb-commerce-db
5. Copy the database_id from the output into wrangler.toml.
6. Initialize database:
   npx wrangler d1 execute hb-commerce-db --remote --file=./schema.sql
7. Add Resend API key:
   npx wrangler secret put RESEND_API_KEY
8. Optional but recommended:
   npx wrangler secret put PUBLIC_BASE_URL
   Use: https://www.hbcommercesolutions.com
9. Deploy:
   npx wrangler deploy
10. In Cloudflare dashboard, connect your custom domain to this Worker:
    www.hbcommercesolutions.com
    hbcommercesolutions.com

NOTES
-----
- D1 binding name in wrangler.toml must stay DB.
- Email sender defaults to info@hbcommercesolutions.com in wrangler.toml.
- Verify your domain in Resend before using info@hbcommercesolutions.com.
- If Resend is not configured, email button will not send, but customer links still work.
- Customer can Print / Save PDF from the review page.
- Admin can print or save document from the customer review link.

SECURITY
--------
- First visit /setup after deployment to create the admin account.
- Use a strong password.
- Sessions use HttpOnly secure cookies.


V2 SETUP FIX NOTES
------------------
This version fixes Cloudflare Workers PBKDF2 setup error by using 100000 password-hash iterations instead of 120000.

It also locks first-time admin setup behind a private SETUP_CODE secret. This prevents random website visitors from creating the admin account.

Before opening /setup, run:
  npx wrangler secret put SETUP_CODE

Use a private code, for example:
  HB-PRIVATE-SETUP-2026

Then redeploy:
  npx wrangler deploy

Open setup like this:
  https://www.hbcommercesolution.com/setup?code=HB-PRIVATE-SETUP-2026

After the admin user is created, /setup redirects to /admin/login.


V3 FIXES
--------
- Fixed line item fields so typing no longer loses focus after every character.
- Quote numbers now use QUOTE-HB-YYYYMMDD-XXXX when changing the document type to Quote.
- Customer emails now include a PDF attachment.
- Quote/Estimate emails include a small online approval link.
- Invoice emails do not include an approval link.
- Added homepage service slideshow with visual banners.
- Added service visuals/images on Home, Services, and individual service pages.


V4 ADMIN NAV / PUBLIC CTA FIXES
-------------------------------
- Public navigation Admin Portal now opens the login page.
- Admin Dashboard includes a visible Logout button.
- Admin document editor includes a Logout button.
- Logged-in admin users who visit /admin/login are redirected to /admin/dashboard.
- Homepage "Need a quote for your business?" CTA now uses Contact Us, not Admin Portal.


V5 QUOTE / INVOICE / SIGNATURE / PAYMENT UPDATE
-----------------------------------------------
- Removed Estimate as a document option. The system now uses Quote and Invoice only.
- Quote numbers use QUOTE-HB-YYYYMMDD-XXXX.
- Customer approval is available only for Quotes.
- Approval requires customer name and drawn signature.
- Signature is stored inside the document JSON record and displayed on the quote as proof.
- Approved quotes can be converted into invoices from Admin Dashboard.
- Invoice emails have PDF attachment but no approval link.
- Invoice bottom includes payment options: Check, Zelle, Cash only.
- Admin can mark invoice Open/Paid and store payment method: Check, Zelle, or Cash.


V6 CONTACT EMAIL FIX
--------------------
- Fixed visible Contact Us email to info@hbcommercesolution.com.
- Contact form sends inquiries to CONTACT_TO if set, otherwise EMAIL_BCC, otherwise the email extracted from EMAIL_FROM.
- Contact form now shows an error if Resend/email routing is not configured instead of silently showing success.
- Contact page no longer pushes customers toward the Admin Portal from the business contact card.

Recommended Cloudflare settings:
EMAIL_FROM = "HB Commerce Solutions <info@hbcommercesolution.com>"
EMAIL_BCC = "paulcamerasystems@gmail.com"
Optional secret/variable: CONTACT_TO = "paulcamerasystems@gmail.com"


V7 DESIGN REFRESH
-----------------
- Visual-only styling update.
- No page text/content changes.
- Same HB Commerce navy/orange/green color theme.
- More polished navigation, hero, cards, forms, tables, document preview, and footer.
- Added subtle motion, hover effects, depth, glass-style header, and more dynamic section treatments.


V8 DASHBOARD + MODERN DESIGN UPDATE
-----------------------------------
- Stronger modern/dynamic visual refresh while preserving current color theme and content.
- Admin dashboard now has square navigation tabs/cards:
  Create Quote, Quotes, Invoices, Approved Quotes, Deleted/Canceled.
- Dashboard lists are filtered by selected section.
- Quotes/invoices now have Cancel/Delete action that soft-moves records to Deleted/Canceled section.
- Deleted/canceled records can be restored.
- Invoice Mark Paid opens a modal popup for Check, Zelle, or Cash.
- Approved Quotes list supports Edit, View, Email, Convert to Invoice, and Cancel/Delete.
- Payment method continues to be stored in the document data for accounting history.


V9 WORKFLOW + FULL WEBSITE REDESIGN
-----------------------------------
Dashboard workflow:
- Quotes tab now shows only active/unapproved quotes.
- Approved quotes move into Approved Quotes and no longer appear in Quotes.
- Converted approved quotes are marked Converted and leave Approved Quotes after conversion.
- Open Invoices tab shows only unpaid/open invoices.
- Paid Invoices tab added and shows paid invoices with payment method.
- Deleted/Canceled tab stores canceled records.
- Invoices marked paid redirect to Paid Invoices.
- Cancel/Delete remains soft-delete for recordkeeping.

Website redesign:
- Public homepage redesigned with modern split hero, floating proof elements, service stats, premium cards, and redesigned CTA.
- Services, Payment Processing, POS Software, Security Camera Systems, About, and Contact pages received a stronger modern layout.
- Same HB Commerce navy/orange/green theme and existing service content/features retained.


V10 FULL PUBLIC WEBSITE REDESIGN + DASHBOARD FLOW FIX
-----------------------------------------------------
Admin workflow:
- Quotes tab now excludes approved quotes.
- Approved Quotes tab excludes quotes already converted to invoices.
- Open Invoices tab excludes paid invoices.
- New Paid Invoices dashboard tile lists paid invoices and payment methods.
- Converted quotes are marked Converted and linked to the new invoice.
- Paid invoices move into Paid Invoices after Mark Paid.

Public website:
- Complete new modern homepage layout with welcoming hero, large service showcase panel, stat band, premium service cards, and stronger CTA.
- Complete modern redesign of Services, individual service pages, About, and Contact layouts.
- Same HB Commerce color theme retained: navy, orange, green.
- Existing service offerings and features retained.


V11 CENTRIQPAY MERCHANT SERVICES UPDATE
---------------------------------------
- Renamed Payment Processing service to Merchant Services.
- Added /merchant-services page and legacy /payment-processing redirect.
- Updated public nav, service cards, service page labels, contact options, footer labels, and admin service labels.
- Implemented a CentriqPay Merchant Services page using uploaded CentriqPay logo/banner/icon assets.
- No phone number appears on the Merchant Services page.
- Added subtle money/growth/fintech theme using green glow, growth chart style background accents, payment terminal visuals, and trust badges.
- Existing quote/invoice/admin workflow retained from the previous version.


V12 MOCKUP IMPLEMENTATION
-------------------------
- Implemented the approved visual direction across the live website.
- Home page now follows the dark HB Commerce mockup with strong hero, icon benefit row, service cards, and bottom CTA.
- Merchant Services page keeps the CentriqPay/CentriqPay money-tech mockup theme and assets, with no phone number.
- POS Software page now follows the modern retail POS mockup layout.
- Security Camera Systems page now follows the surveillance/NVR/DVR/camera mockup layout.
- Current admin portal quote/invoice workflow retained from previous versions.


V13 EXACT MOCKUP STYLE UPDATE
-----------------------------
- Public Home, Merchant Services, POS Software, and Security Camera Systems pages now use the approved mockup visuals directly for a much closer match to the screenshots.
- Top navigation changed to the dark mockup-style header with white logo block, request quote button, and admin portal button.
- About and Contact pages redesigned to match the same dark navy/orange mockup style.
- Existing admin quote/invoice workflow and database behavior retained from prior version.
- Merchant Services still uses CentriqPay branding and no phone number.


V14 EXACT MOCKUP CLONE
----------------------
- Merchant Services, POS Software, and Security Camera Systems now render the approved mockup images directly for the closest possible visual match.
- Home page uses the approved HB Commerce mockup crop.
- Invisible clickable navigation/CTA zones are layered over mockup images so pages remain visually exact while still usable.
- Admin Portal, quote/invoice workflow, approvals, payments, and database functionality are retained.
- Services page, About, Contact, and Admin remain live HTML/CSS pages.


V15 FUNCTIONAL EXACT PAGES
--------------------------
- Replaced screenshot header areas with a live, crisp, functional website header.
- Header tabs are consistent across website: Home, Solutions, About Us, Contact Us, Request a Quote, Admin Portal.
- Services wording replaced with Solutions in navigation.
- Removed Industries and Resources tabs.
- Admin Portal link clears session and asks for login every time from public header.
- Service pages use high-quality cropped mockup body visuals to avoid blurry scaled navigation.
- Only one primary service-page CTA is active per page.
- Invisible hotspots make mockup buttons actionable.
- Added /quote-request form for general customer quote requests.
- Added /merchant-services/request form with legal name, DBA, address, volume, ticket, business type, smoke shop products, and two statement uploads.
- Merchant request sends PDF summary plus uploaded statements to configured business inbox.


V16 SOLUTIONS MENU FIX
----------------------
- Fixed Solutions dropdown visibility.
- Dropdown now uses a clean white panel, navy text, orange top border, and orange hover state.
- Increased dropdown z-index so it stays above page content.
- No workflow, database, quote, invoice, or page content changes.


V17 REFINEMENTS
---------------
- Security Camera Systems page card buttons View NVR/View DVR/View Cameras removed from visual.
- Security page now keeps only the main Get a Quote action.
- Public Admin Portal button removed from top navigation and moved to a small footer Admin link.
- Public Admin link clears any session and forces login.
- Solution-page button hotspots now show hover/click visual feedback.
- Quote Request form auto-selects the Solution Needed field when opened from POS or Security pages.
- Homepage hero Request Quote button removed.
- Homepage now includes three solution banners using Merchant, POS, and Security page visuals.
- Clicking anywhere on a homepage solution banner opens that solution page; clicking its button opens the proper request form.


V19 FULL HERO BANNERS
---------------------
- Rebuilt the homepage hero so the entire hero section is the rotating banner area.
- Slides include: Home/Smart Solutions, Merchant Services, POS Software, Security Camera Systems.
- Each full hero slide has its own text, background visual, and CTA.
- Clicking the full slide background opens the related page.
- Clicking the CTA opens the appropriate request form.
- Removed separate lower solution-banner placement from v17/v18.


V20 SECURITY BUTTON CACHE FIX
-----------------------------
- Security Camera Systems page uses a new versioned image URL: /assets/security-body-v20.webp.
- Removed View NVR Systems, View DVR Systems, and View Cameras from the visual.
- Versioned URL prevents browser/Cloudflare cached old security image from continuing to show.
- No admin/quote/invoice workflow changes.


V21 SECURITY TEXT FIX
--------------------
- Reworked security page image cleanup so the lower bullet text is no longer cut off.
- Uses new cache-busting asset URL: /assets/security-body-v21.webp
- The three buttons remain removed.


V22 ADMIN PORTAL QUOTE/INVOICE FIXES
------------------------------------
- Quote/invoice PDF now embeds the HB Commerce Solutions logo.
- Quote PDF now contains clickable Approve Quote and Decline Quote links.
- Customer review page supports declining a quote.
- Added Save and Email button in the admin document editor.
- ZIP lookup now runs automatically when a 5-digit ZIP is entered.
- Line-item entry is now arranged horizontally for faster admin entry.
- Number inputs are protected against mouse-wheel value changes.
- New line items are inserted below existing rows and focus the new item field.


V23 REPORTS, MOBILE, AND ADMIN WORKFLOW FIXES
---------------------------------------------
- Removed the strong/orange overlay hover effect on solution-page mockup buttons.
- Approved quotes now remain in Approved Quotes after conversion and keep approval signature/date.
- Convert to Invoice no longer changes the approved quote status to Converted; it links the invoice back to the approved quote.
- Added Reports section in Admin Portal.
- Reports show paid invoice sales by month, state sales tax collected/due, and optional federal tax estimate by rate.
- Reports can be downloaded as CSV.
- Reports can be emailed to an accountant, and the accountant email is saved for future use.
- PDF header now includes the HB Commerce logo plus text fallback.
- Added mobile-friendly versions for solution pages and general mobile CSS improvements.


V24 DEPLOY BUILD FIX
--------------------
- Fixed Wrangler build error: Expected ';' but found 'class' in renderItems.
- The horizontal line-item template is now correctly escaped inside the Admin document editor script.
- No feature changes from v23.


V25 PROFESSIONAL MOBILE WEBSITE
-------------------------------
- Added professional mobile navigation with a compact menu button.
- Rebuilt mobile homepage as a dedicated mobile layout instead of shrinking the desktop hero.
- Added professional mobile versions of Merchant Services, POS Software, and Security Camera Systems pages.
- Mobile solution pages now use clean live sections/cards instead of tiny desktop screenshots.
- Improved mobile forms, quote request, contact page, tables, buttons, and layout spacing.
- Desktop site and admin features from v24 retained.


V26 MOBILE GRAPHICS UPDATE
--------------------------
- Restored stronger graphics on mobile solution pages.
- Each mobile solution page now has a full visual hero using the actual page artwork.
- Added a clean preview image card further down each solution page for better visual continuity.
- Keeps the professional mobile layout from v25.


V27 POLISHED MOBILE SOLUTION GRAPHICS
-------------------------------------
- Reworked mobile solution graphics completely.
- Removed the untidy screenshot-background treatment from mobile solution pages.
- Added clean professional inline SVG graphics for Merchant Services, POS Software, and Security Camera Systems.
- Kept the mobile layout clean, readable, and app-like.
- Desktop pages and Admin Portal features are unchanged from v26.


V28 MOBILE GRAPHICS + ADMIN APP
-------------------------------
- Mobile solution graphics now use clean cropped artwork from the regular desktop solution pages.
- Removed untidy screenshot-background and duplicate preview-frame treatment.
- Added /admin-app private launch page for one-click Admin Portal access.
- Added PWA manifest and service worker routes so Admin App can be installed/Add-to-Home-Screen on mobile/desktop.
- Admin App always launches through /admin/logout so it clears session and asks for login.


V29 ADMIN APP FIX
-----------------
- /admin-app is now a professional standalone Admin login screen, not a website landing page.
- /ADMIN-APP and other capitalization variants now work by case-insensitive routing.
- Added proper square app icon for install/Add-to-Home-Screen support.
- Admin login uses PWA manifest and service worker.
- Admin dashboard/pages now use a private app-style header instead of customer website header.
- Logout links are made more robust and route back to /admin-app login.
- Mobile solution graphics from v28 are retained.


V30 MOBILE GRAPHICS + DASHBOARD FIX
-----------------------------------
- Removed Logout button from the Command Center hero/banner.
- Kept Logout in the private Admin App header only.
- Reworked mobile solution graphics again with cleaner custom mobile-first visual panels.
- Removed screenshot/crop/preview-image treatment from mobile solution pages.
- Desktop and Admin App functionality from v29 retained.


V31 APP ICONS
-------------
- Added professional HB Commerce Solutions icon logo for installed desktop/mobile app.
- Added /assets/hb-app-icon-512.png, /assets/hb-app-icon-192.png, /assets/hb-favicon.png, and /apple-touch-icon.png routes.
- Updated Admin App manifest to use the new HB icon logo.
- Added public site manifest and favicon/apple-touch-icon metadata.
- Updated favicon route so browser tab and installed app use the HB icon.


Update: This v32 package uses the white-background HB icon for desktop app, mobile app, manifest icons, favicon, and admin app branding.


V33 INSTALL APP BUTTON
----------------------
- Added a floating bottom-right "Install App" button.
- Button works on the public website and Admin App login.
- On Chrome/Edge desktop and Android, it uses the browser install prompt when available.
- On iPhone/iPad or unsupported browsers, it shows Add-to-Home-Screen instructions.
- Added versioned manifest/icon routes to help browsers pick up the new white HB icon after deleting/reinstalling the app.


V34 INSTALL BUTTON NO POPUP
---------------------------
- Removed the blocking Install App popup/modal completely.
- Bottom-right Install App button remains.
- If the browser provides an install prompt, the button opens it directly.
- If the browser does not provide the prompt, the button changes its own label with brief instructions instead of showing a popup.
- Fixed the issue where the popup could not be closed because the modal CSS overrode the hidden attribute.


V35 INSTALL BUTTON DIRECT ONLY
------------------------------
- Removed the fallback label behavior such as "Use Browser Install Menu".
- The Install App button now only appears when Chrome/Edge provides the real direct install prompt.
- If the app is already installed or the browser does not provide the install prompt, the button stays hidden.
- No popup, no instruction modal, no fallback message.


V36 LINE ITEM SALE PRICE FIELD
------------------------------
- Added Sale Price field to each Admin Portal line item.
- If admin enters Sale Price, Markup % is calculated automatically from Cost and Sale Price.
- If admin changes Markup %, Sale Price recalculates from Cost and Markup.
- If admin changes Cost while Sale Price is present, Markup % recalculates.
- Quote/invoice PDF and totals use Sale Price as the customer-facing unit price.
- Cost and markup remain private and do not show to the client.


V37 EUFY ORDER SECTION
----------------------
- Added eufy NVR Security System bundle/order section to Security Camera Systems page.
- Lists 19 eufy collection items with names and prices from the eufy NVR collection.
- Added Add to Cart cart system, customer checkout form, billing/shipping addresses, and payment preference selection: ACH, Wire, Check.
- Customer order generates a Quote automatically and emails the quote PDF to the customer with BCC to the configured business inbox.
- Customer must approve/sign quote online before admin converts to invoice.
- Quote/PDF/customer view shows selected payment option and shipping-after-payment notice.


V38 EUFY STORE PAGES
--------------------
- Removed the prior eufy product section from the bottom of Security Camera Systems.
- Added a live four-card Security Camera Solutions section: NVR, DVR, Cameras, EUFY PoE NVR Camera Systems.
- Added /security-camera-systems/eufy-poe-nvr-camera-systems collection page.
- Added individual eufy product detail pages.
- Added product images, descriptions, sale/regular pricing display, coupon display, cart, checkout form, quote generation, and approval workflow.
- eufy orders generate a Quote first and ship only after approval and payment received/cleared.


V39 EUFY CART CHECKOUT
----------------------
- Added Cart link to the website header between Contact Us and Request a Quote.
- eufy products now add to a persistent shopping-style Quote Cart using browser local storage.
- Added /cart page with quantity updates, remove buttons, totals, and Checkout button.
- Added /checkout page with cart summary and customer billing/shipping/payment preference form.
- Removed checkout/customer form from under product listing/detail pages.
- Product and detail pages now behave like a normal shopping page: Add to Quote Cart -> Cart -> Checkout -> Quote generated.
- eufy product pricing now shows item-specific coupon discount amounts based on 10% off up to $50 instead of one flat discount across all items.


V40 EUFY COUPON + CART FIX
--------------------------
- Added eufy-style coupon checkbox to product cards and product detail pages.
- Coupon discounts are now item-specific and stored per product.
- Cart stores whether the customer applied coupon discount for each item.
- Cart totals update based on checked/unchecked coupon state.
- Checkout quote generation carries coupon/applied discount into quote line-item discount.
- Removed View Cart button next to Add to Quote Cart on detail page and removed View Cart from add-to-cart toast.


V41 EUFY CHECKOUT COUPON CODE
------------------------------
- Added Coupon Code field to the eufy checkout page.
- Customer can paste/copy a coupon code at checkout and click Apply Code.
- Coupon applies only once per matching eufy item.
- If coupon was already checked on item/card/cart, entering the code does not apply any duplicate discount.
- Cart normalizes duplicate regular/coupon rows.
- Zero-discount items now hide coupon checkboxes instead of showing Save $0.
- Rechecked public eufy collection/product text and corrected several regular-price/discount mismatches exposed by accessible page text and the user-provided screenshot example.


V42 ADMIN EUFY MANAGER
----------------------
- Added EUFY link in the private Admin App header next to Dashboard.
- Added /admin/eufy product manager.
- Admin can edit coupon amount, coupon code, regular price, description, image URL, video URL, bullets, active/hidden status.
- Admin can add new eufy items or delete/reset items.
- Public eufy product pages/cart/checkout now load product/coupon data from Admin settings immediately after refresh.


V43 EUFY ADMIN STATUS + DELETE
------------------------------
- Added Active / Inactive controls directly beside each product in Admin > EUFY.
- Active shows the product on the public website.
- Inactive hides the product from the public website.
- Delete beside each listing deletes the item from the saved eufy product list.
- Fixed the editor delete issue where the hidden save action could prevent delete from running.
- Saved empty product lists are respected instead of falling back to defaults.


V44 TAX MANAGER FIX
-------------------
- Added Admin > Tax manager in the private Admin Portal.
- Added a server-side /admin/tax-lookup endpoint used by the quote/invoice ZIP lookup.
- Added built-in Illinois overrides for 60107 Streamwood, 60016 Des Plaines, and 60007 Elk Grove Village at 10.000%.
- ZIP lookup now checks Admin Tax overrides first, then built-in overrides, then state base fallback.
- Eufy checkout quotes now use the same tax lookup for shipping ZIP instead of state-only tax.
- Admin can add/update/delete ZIP tax overrides without changing code.


V45 TAXJAR ADDRESS-LEVEL TAX
-----------------------------
- Added optional TaxJar SmartCalcs integration using TAXJAR_API_KEY secret.
- Eufy checkout can calculate sales tax from full shipping street/city/state/ZIP before quote submission.
- Eufy order quote recalculates tax server-side before quote/email creation.
- Admin quote/invoice ZIP lookup now sends street/city/state/ZIP to the server tax lookup.
- If TaxJar is configured, the app uses address-level/rooftop-capable rates.
- If TaxJar is not configured or unavailable, the app falls back to Admin Tax overrides, then state fallback.
- Add secret: npx wrangler secret put TAXJAR_API_KEY
- Optional origin vars can be configured in wrangler.toml: TAX_ORIGIN_ZIP, TAX_ORIGIN_STATE, TAX_ORIGIN_CITY, TAX_ORIGIN_STREET.


V46 ONLINE ORDERS + TAX REVIEW WORKFLOW
---------------------------------------
- Removed client-facing eufy checkout tax preview.
- Checkout now places an Online Order request only; it does not generate/email a quote to the customer.
- Added Admin > Online Orders section.
- Admin can review online orders, see billing/shipping/payment preference/items, and convert an order into a Draft Quote.
- Converting an online order into a quote recalculates sales tax using TaxJar address-level tax when TAXJAR_API_KEY is configured, otherwise existing Admin Tax overrides/fallbacks are used.
- Converted quote can be revised, adjusted, saved, and emailed from the normal quote editor.
- TaxJar response now stores county/jurisdiction data when available.


V47 DASHBOARD ORDERS + CITY TAX FALLBACK
----------------------------------------
- Removed Online Orders from the Admin App header.
- Added Online Orders dashboard tile between Create Quote and Quotes.
- Improved tax fallback: no longer silently overwrites quote tax rate with state base-only rate when local rate is unknown.
- Added built-in city combined fallback examples for Elgin IL 8.5%, Streamwood IL 10%, Des Plaines IL 10%, Elk Grove Village IL 10%, and Chicago IL 10.25%.
- Tax lookup now displays state + local split where known.
- For truly precise address-level rates, TaxJar/Avalara/API or Admin Tax verified overrides are still required.


V48 LTS PRODUCTS + MANAGER
---------------------------
- Replaced Security Camera Systems category cards with LTS DVR/NVR, LTS Cameras, and EUFY PoE NVR Camera Systems.
- Added LTS DVR/NVR public catalog page.
- Added LTS Cameras public catalog page.
- Added LTS product detail pages.
- LTS products show no public pricing; customers add to quote cart to request quote.
- Cart/checkout now supports mixed EUFY and LTS items.
- Online Orders flow still sends order to Admin first for pricing/tax review before quote.
- Added Admin > LTS Product Manager with add/edit/active/inactive/delete controls similar to EUFY.
- Seeded LTS product data from accessible LTS recorder/camera pages and your LTS quote items.


V49 LTS IMAGE VERIFICATION
--------------------------
- LTS public pages now show only products that are Active and have a verified image.
- This prevents mismatched SKU/product photos from appearing to customers.
- Admin > LTS now has an image preview area.
- Admin > LTS now has an "I verified this image matches this exact SKU/model" checkbox.
- Admin > LTS now shows counts for total items, published items, and items hidden until image verification.
- LTS products without verified images are hidden from the public LTS DVR/NVR and LTS Cameras pages.
- Existing LTS items remain in Admin so you can paste official image URLs, verify them, and publish them safely.


V50 LTS OFFICIAL SKU IMAGES
---------------------------
- Public LTS product cards now attempt to load official LTS product images by SKU/model using the official LTS site search/product pages.
- The public site no longer requires manual verified images before showing Active LTS products; it uses dynamic official image lookup by SKU when no saved verified image is present.
- Admin > LTS has Find Official Image by SKU and Sync Missing Images actions to save official image URLs into the database/list.
- Saved verified image URLs still take priority.
- Placeholder appears only if the official image lookup cannot find a matching product image.


V51 SECURITY BROWSE BUTTON
--------------------------
- Changed the Security Camera Systems hero CTA from "Get a Quote" to "Browse Security Products".
- The button now scrolls to the product-category section on the same page.
- Added id="security-products" to the category section.
- Mobile security CTA also points to the product section.


V52 SECURITY BUTTON OVERLAY
---------------------------
- Moved the Security Camera Systems hero CTA lower on the security page.
- The new "Browse Security Products" button now sits directly over the non-operable mockup buttons so they are hidden.
- Home page behavior remains unchanged.


V53 SECURITY BUTTON ALIGNMENT FIX
---------------------------------
- Moved Browse Security Products button directly over the old non-operable mockup buttons.
- Expanded the button area so both original image buttons are fully covered.
- Removed hover movement/glow so the old button image does not show when mouse is over it.


V54 CUSTOMER ACCOUNTS / ANTI-SPAM GATE
--------------------------------------
- Added customer account registration, login, logout, email verification, forgot password, and reset password.
- Customers must have a verified active account before they can submit contact inquiries, quote requests, merchant-service requests, or checkout/place online orders.
- Website can still be browsed as an informational website without login.
- Added public Account / Client Login navigation.
- Added Admin Portal > Customers section to view, edit, verify, deactivate, or delete customer accounts.
- Customer accounts and customer sessions are stored in Cloudflare D1 settings JSON.
- Verification/reset emails use the existing RESEND_API_KEY email setup.
- Recommended banner implementation note: do not bake buttons into future banner images. Use clean button-free banner artwork and overlay real HTML buttons so they remain clickable and styleable.


V55 REPORTS + CART GATE
-----------------------
- Add-to-cart now requires a verified customer account. If a visitor tries to add hardware without login, they are sent to customer login.
- Checkout was already protected; now cart additions are protected too.
- Added /api/customer-status for verified customer session checks.
- Reports now support both Export CSV and Export PDF.
- CSV report is now structured with report title, company header, summary section, detail table, totals, and notes.
- PDF report uses HB Commerce Solutions logo, orange/navy/green invoice-style theme, summary boxes, detail table, and a light watermark.
- Report email now attaches both CSV and PDF.
- Future homepage/solution banners should be created without embedded button artwork; real clickable HTML buttons should be overlaid by the website.


V56 HOMEPAGE BANNERS + HEADER ICONS
-----------------------------------
- Applied the new no-button banner images to the homepage hero slider.
- Slider order: homepage, merchant services, POS software, security camera systems.
- Added real clickable HTML CTA buttons over the banners instead of baking buttons into the images.
- Replaced header text links for Client Login and Cart with professional icon buttons.
- Kept customer-account gate, add-to-cart login requirement, and CSV/PDF report upgrades from v55.


V57 OPTIMIZED FINAL DEPLOY
--------------------------
- Optimized embedded logo, icons, banners, and legacy website image assets to reduce Worker size.
- Keeps the v56 homepage banner slider, header account/cart icons, customer account protections, and professional report exports.
- Designed to avoid the Cloudflare free-plan 3 MiB Worker size validation error.


V58 BANNER ALIGNMENT FIX
------------------------
- Hid duplicate slider dot controls because the new banner images already include visual slide dots.
- Adjusted real HTML button positions slide-by-slide so buttons no longer sit on top of banner text.
- Kept buttons real/clickable while removing visual mismatch.
- Keeps v57 optimized size approach for Cloudflare Worker free-plan deployment.


V59 BANNER VISIBILITY + CONTROLS
---------------------------------
- Adjusted homepage banner container to the actual 1600x607 banner aspect ratio so the full banner artwork is visible.
- Removed full-banner click zones; only real buttons are clickable now.
- Repositioned real buttons below banner text and away from paragraph text.
- Added left/right arrow controls for manual banner sliding.
- Re-enabled dot controls and made them clickable.
- Increased auto-slide speed from 5.6 seconds to 3.9 seconds.


V60 BANNER CLARITY + HEIGHT FIX
-------------------------------
- Rebuilt homepage slider banners from higher-quality source artwork at 1600x560.
- Reduced banner vertical height slightly.
- Uses cover/object-position without vertical stretching to prevent pixel breaking.
- Real slider dots are now invisible click zones over the baked-in dots, so the dots are not doubled but remain clickable.
- Button positions adjusted lower for each banner so they do not overlap title/subtitle/paragraph text.
- Arrows remain available for manual slider control.


V61 FINAL BANNER LAYOUT FIX
---------------------------
- Rebuilt homepage slider banners from the full banner artwork at 1672x520.
- This reduces vertical height without cutting off the original banner content.
- Button positions were adjusted per-slide so CTAs sit in open areas instead of covering banner text.
- The banner image itself is not clickable; only CTA buttons are clickable.
- The visible dots are the dots already inside the banner artwork. Website dot controls are invisible clickable zones, removing double-dot display.
- Side arrows remain enabled for manual sliding.


V62 PROFESSIONAL BANNER FINAL
-----------------------------
- Reduced homepage banner vertical height by rebuilding the banners at a shorter 1672x450 layout.
- Kept horizontal width full-screen; no max-width restriction.
- Preserved the full banner content by compressing/reformatting the banner asset instead of clipping the content.
- Repositioned CTA buttons per banner so they sit below text and in the correct open area.
- Replaced double-dot look with one real dot control row that covers the dots baked into the image.
- Kept side arrows smaller and closer to the edge so they do not interfere with banner text.


V64 ORIGINAL BANNERS + EXACT BUTTONS
------------------------------------
- Restored the original 1916x821 banner artwork without cropping or reshaping.
- The slider uses the original 1916/821 aspect ratio to avoid vertical distortion.
- Real CTA buttons are aligned over the original button areas in the banner artwork.
- The banner image itself is not clickable; only the CTA buttons are clickable.
- One clean real dot control row is used; no duplicated image dots.
- Side arrows remain for manual slider control.


V65 BANNER + PAYMENT FIX
------------------------
- Restored the homepage slider behavior so each slide displays one banner only; no cross-fade ghosting/overlapping slides.
- Kept the original banner artwork aspect ratio with object-fit: contain so nothing is cut off or cropped.
- Re-aligned each CTA button using percentage-based positions/sizes so the buttons scale with the banner.
- The banner itself remains non-clickable; only CTA buttons are clickable.
- Mark Paid in Admin dashboard now opens the reliable Invoice Payment page (/admin/pay?id=...) instead of depending on the popup modal script.


V66 FINAL NO-BUTTON BANNERS
---------------------------
- Replaced the current homepage slider banners with the new no-button banner artwork.
- Removed all real overlay CTA buttons from the homepage banner slider.
- Removed slider side arrows.
- Kept the existing auto-slide/dot-slider behavior.
- Homepage banner is informational only and is not clickable.
- Merchant Services, POS Software, and Security Camera Systems banners are clickable and route to their matching solution pages.
- Preserved the generated banner artwork dimensions/aspect ratios and used object-fit: contain so banner content is not cropped.
- Kept the Admin Mark Paid fix from v65.


V67 HOMEPAGE BANNER MAX-WIDTH 1600
----------------------------------
- Homepage banner slider is now centered with max-width: 1600px and margin: 0 auto.
- Banner images use object-fit: contain so the original artwork is not cropped or cut off.
- Existing no-button banner behavior is preserved.
- Merchant, POS, and Security banners remain clickable; homepage banner remains informational.
- Side arrows remain removed; dot controls remain available.


V68 HOMEPAGE BANNERS 1680x792
--------------------------------
- Updated homepage slider banners to a centered max width of 1680px.
- Unified homepage slider aspect ratio to 1680x792 for all homepage banners.
- Kept object-fit: contain so no banner content gets cropped or cut off.


V72 MOCK COMPONENT CLONE
------------------------
- Rebuilt homepage from HTML/CSS layout using separate cropped visual components from the approved mock.
- This is not one full-page image; the header, dropdowns, links, cards, and page sections are actual website layout elements.
- Uses the exact mock-style HB Commerce Solutions logo globally through /assets/logo.png.
- Uses same visual components from the mock for the hero device/dashboard area and the three service cards.
- Solutions dropdown: Merchant Services, POS Software, Security Camera Systems.
- Products dropdown: LTS DVR/NVR, LTS Cameras, EUFY Camera Systems.
- Compliance section removes the three compliance logos and keeps only the wording COMPLIANT. CERTIFIED. TRUSTED. with supporting text.
- About Us and Contact pages were matched to the same dark visual theme.


V73 HOMEPAGE BODY ALIGNMENT FIX
-------------------------------
- Fixed homepage main body proportions to match the approved mock more closely.
- Expanded the homepage content width so the hero headline no longer stacks into a narrow column.
- Aligned the hero text beside the main visual image like the mock.
- Fixed the bottom “Trusted by Businesses Like Yours” section so the image is not clipped/cut off.
- Fixed the compliance panel sizing so it aligns with the trusted-business strip.
- Preserved the mock-style logo, Solutions dropdown, Products dropdown, and dark theme from v72.


V74 DARK THEME + SECURITY CARDS
-------------------------------
- Applied the homepage dark navy/orange/green color theme across the main public pages.
- Updated services, info, account, product, LTS/eufy, and solution-related sections to match the homepage theme.
- Rebuilt the Security Camera Systems product option section to look like the homepage service-card section.
- Security page options now show dark glass-style cards for LTS DVR/NVR, LTS Cameras, and EUFY PoE NVR Camera Systems.
- Kept admin portal functionality and existing quote/invoice behavior unchanged.


V75 SOLUTION PAGE CLONES + SECURITY SQUARES
-------------------------------------------
- Replaced full mock-image solution pages for Merchant Services, POS Software, and Security Camera Systems with real HTML/CSS sections.
- Solution page text, buttons, feature strips, and cards are now real website elements, not hotspots over full-page mock images.
- Kept visual components from the approved mock style as separate image elements so the look stays close without using one patched mock image.
- Rebuilt the Security Camera Systems product-option cards as square-style dark cards matching the homepage card theme.
- Restored product visuals on the three Security options: LTS DVR/NVR, LTS Cameras, and EUFY PoE NVR systems.
- Kept homepage, customer accounts, cart login gate, reports, and admin payment workflow from v74.


V77 FINAL SOLUTION HEROS
------------------------
- Applied the approved final hero visuals to Merchant Services, POS Software, and Security Camera Systems.
- Merchant Services hero now includes CentriqPay branding and uses the approved CentriqPay-style visual.
- The solution page hero images render at full width with no cropping or clipping.
- CTA areas on the hero visuals remain clickable through invisible hotspot links.
- Fixed the Create Account / Forgot password or login link color to white, with orange hover state.
- Retained security product cards, customer account protection, admin portal, LTS/EUFY managers, quote/invoice, and reports workflows.


V78 REAL COMPONENT SOLUTION PAGES
---------------------------------
- Rebuilt the solution-page main bodies as real HTML/CSS sections instead of full pasted hero images.
- Uses cropped visual components only for the device/dashboard/security product imagery; text, CTA buttons, brand layout, feature strips, and body cards are real website elements.
- Enlarged the right-side solution visuals and reduced the left text scale for a better professional balance.
- Added CentriqPay brand/logo component on Merchant Services.
- Fixed Create Account / Forgot password or login link color to white with orange hover.
- Preserved homepage, Security product cards, customer accounts, cart gate, Admin Portal, reports, LTS/EUFY managers, quote/invoice, and Mark Paid workflow.


V79 ADMIN THEME + MOBILE/TABLET RESPONSIVE
------------------------------------------
- Applied the public website dark navy / green / orange theme to the Admin Portal.
- Updated Admin Portal topbar, dashboard hero, tiles, forms, inputs, tables, notices, and editor panels.
- Updated Admin Login screen to match the dark theme.
- Improved responsive layout for smartphones, tablets, iPads, and smaller laptop screens.
- Added a mobile-friendly public header/menu for the current HB v72/v78 site structure.
- Improved mobile/tablet behavior for homepage sections, solution pages, product pages, cart/checkout, admin dashboard, and document editor.
- Preserved existing features: homepage, solution heroes, Security product cards, customer accounts, cart gate, LTS/EUFY managers, reports, quotes, invoices, and Mark Paid workflow.


V80 READABLE ADMIN + FIXED TAX + ONLINE ORDER CANCEL
----------------------------------------------------
- Improved Admin Portal font contrast/readability across dashboard, orders, forms, tables, cards, and panels.
- Added Cancel/Delete Order workflow for online orders.
- Cancel/Delete requires an admin reason.
- When email is configured and the order has a customer email, the customer is notified with the cancellation reason.
- Changed tax logic across quotes, invoices, online orders, reports, PDFs, CSV exports, and admin calculations to a fixed 10% rate.
- Disabled TaxJar/tax override logic from active calculations; Admin Tax page now shows fixed 10% status only.
- Document editor tax field is read-only at 10.000%.


V81 MOBILE MENU FIX
-------------------
- Rebuilt the mobile/tablet public navigation so it opens as a clean vertical menu panel.
- Fixed mobile menu layout where Home/Solutions/Products/About/Contact/Login/Cart were wrapping awkwardly across the screen.
- Mobile dropdown sections now stack cleanly with readable submenu links.
- Added smartphone-specific solution-page hero spacing and image polish.
- Added tablet/iPad two-column card/product behavior.
- Preserved all v80 fixes: readable admin theme, online order cancel/delete with email reason, and fixed 10% tax.


V82 ADMIN MOBILE APP
--------------------
- Added a real mobile menu for the Admin Portal.
- Admin header now behaves like the public mobile menu on phones/tablets.
- Admin navigation stacks cleanly for mobile: Dashboard, Orders, Customers, EUFY, LTS, Tax, Reports, Logout.
- Improved mobile/tablet admin dashboard, tiles, online orders, forms, tables, customer manager, EUFY/LTS manager, reports, tax page, and document editor.
- Tables and line items remain horizontally scrollable where needed so the admin can still work from a phone.
- Preserved all v81/v80 fixes: public mobile menu, readable admin theme, fixed 10% tax, online order cancel/delete with required reason and customer email notification.


V83 MERCHANT APPLICATIONS
-------------------------
- Added square Merchant Services page option cards:
  1) POS + Merchant Services
  2) Merchant Services Only
- Added verified-client application forms for both options.
- Applications collect business info, owner/principal info, ACH bank info, required ID upload, required void-check upload, typed signature, and submit button.
- POS + Merchant Services adds POS-specific fields.
- Merchant Services Only uses fields aligned to the uploaded merchant processing application template.
- Application submission generates a professional PDF.
- Customer receives a PDF copy by email.
- HB Commerce receives the PDF plus Driver License/ID and Void Check attachments by email when EMAIL_BCC/Resend are configured.
- Admin Portal has two new sections:
  POS+MS Apps and MS Apps.
- Admin can review submitted applications and download the application PDF.


V84 APPLICATION DRAFT + PRIVACY
-------------------------------
- Protected confidential application inputs with password-style dots:
  FEIN/Tax ID, SSN, routing number, and account number.
- Added Save Draft button to the merchant application forms.
- Draft saves application fields without requiring file uploads or required-field completion.
- When the logged-in client returns to the same application type, the latest saved draft reloads automatically.
- Drafts are hidden from Admin application lists until submitted.
- Final submission can continue from a saved draft and updates the same application number.
- Moved the signature checkbox to the left of the consent text with proper alignment.


V85 ADMIN APPLICATION TILES
---------------------------
- Removed POS+MS Apps and MS Apps from the Admin Portal top navigation.
- Added POS + MS Apps and Merchant Apps as square dashboard tiles with the other command-center tiles.
- Dashboard counts submitted applications separately from quotes/invoices/orders.
- Draft applications remain hidden from dashboard counts and admin application lists until submitted.
- Preserved v84 privacy/draft application workflow, fixed 10% tax, mobile menus, and admin mobile app layout.


V86 BRIGHTER HOME SOLUTION TABS
-------------------------------
- Brightened only the three homepage square solution tabs/cards.
- No layout, routing, admin, tax, application, or mobile behavior was changed.


V90 EXACT CLONE CARDS + SERVICES PAGE
-------------------------------------
- Rebuilt homepage solution cards as real HTML/CSS/SVG components, not pasted mock images.
- Redesigned cards to match the mock-card structure more closely: left circular icon, title/description, checkmark feature list, Learn More action, right-side product visual, and colored neon line background.
- Applied the same exact card component to the /services page.
- Fixed the /services page error by removing the undefined homeHeroVisual() call.
- Preserved previous workflows and features from v89/v88/v84/v83/v82/v80.


V91 REAL COMPONENT MOCK CARDS AND VISUALS
-----------------------------------------
- Rebuilt homepage and /services solution cards again as real HTML/CSS/SVG components that follow the original mock-card structure more closely.
- Rebuilt the Trusted by Businesses strip as real HTML/CSS/SVG instead of a blurred image.
- Rebuilt the main solution-page right-side visuals as real HTML/CSS components so the old embedded mock text/buttons no longer appear inside the visual area.
- Merchant, POS, and Security solution pages now show real text/buttons on the left and real component visuals on the right.
- Preserved all previous application, admin, tax, mobile, and storefront workflows.


V92 RESTORE SOLUTION VISUALS + HOME CARDS
-----------------------------------------
- Restored the homepage / services solution cards to the v90 exact-clone card system.
- Restored Merchant Services, POS Software, and Security Camera Systems page visuals back to the mock-image based visuals without the duplicated text/button problem.
- Preserved the newer application, admin, mobile, tax, and portal features from the latest build.


V93 HOMEPAGE FIX
----------------
- Restored the missing industry trust strip helper that caused the homepage to break.
- Kept the solution-page visual panels as the clean mock visuals without extra text/button/logo overlays.
- Preserved the homepage/services card system and all previous site/admin/application features.


V94 ADMIN NEON ORANGE NAV
--------------------------
- Added neon-orange borders to the Admin Portal top navigation tabs/buttons.
- Added matching orange glow to the Admin Portal logo frame and mobile menu button.
- Added matching neon-orange borders to top action buttons inside Admin page title rows.
- Preserved all prior website, admin, mobile, application, tax, order, and storefront functionality.


V95 ADMIN 3D NEON TABS
----------------------
- Added 3D neon-orange styling to Admin top menu buttons.
- Added matching 3D neon-orange borders to Admin dashboard square tabs/tiles.
- Added 3D press/hover states for Admin nav buttons, action buttons, tiles, and list tabs.
- Preserved all website, admin, order, tax, application, and mobile features from v94.


V96 CREATE INVOICE FIX
----------------------
- Fixed the Admin Portal Create Invoice action.
- Added direct routes:
  /admin/create-quote
  /admin/create-invoice
- Updated the Admin Command Center top buttons to use those direct routes.
- Added a new square dashboard tile: Create Invoice.
- Fixed the Admin hero overlay so decorative layers cannot block button clicks.
- The direct invoice form opens as New Invoice and saves as an Open invoice without needing quote conversion.
- Preserved v95 3D neon Admin styling and all prior website/admin/application features.


V97 LINE ITEM READABILITY FIX
-----------------------------
- Fixed Admin document line item readability in Create Quote / Create Invoice forms.
- Line item cards now use the dark theme instead of white cards with unreadable light text.
- Inputs, labels, taxable checkbox, calculated totals, and remove button are now readable.
- Preserved Create Invoice fix and v95 Admin 3D neon styling.


V98 LINE ITEM INPUT FONT FIX
----------------------------
- Fixed invisible typed text inside Add Line Item input fields.
- Added strong dark input styling for line-item fields.
- Added Chrome/Safari autofill override so autofilled/focused fields no longer turn light blue with invisible text.
- Preserved v97 line item readability, v96 Create Invoice fix, and v95 Admin 3D neon styling.


V99 REPORTS PROFIT CHARTS + CHECKBOX
------------------------------------
- Fixed Taxable checkbox visibility inside Admin Add Line Item.
- Added gross profit reporting per invoice.
- Added monthly gross profit summary.
- Added yearly report mode with total taxable sales, non-taxable sales, sales tax collected, total sales, internal cost, and gross profit.
- Added monthly sales and gross-profit charts.
- Updated CSV/PDF exports to include profit, non-taxable sales, and monthly breakdown.
- Report email now sends the updated CSV/PDF report.


V100 REPORT CHART/BREAKDOWN/CHECKBOX FIX
----------------------------------------
- Fixed chart value labels clipping at the top.
- Monthly Breakdown table now only appears for Yearly Report when "Show Monthly Breakdown Table" is checked.
- Yearly Report mode hides Month/Federal Estimate fields and shows Year + Monthly Breakdown checkbox instead.
- Monthly Report mode keeps Month + Federal Estimate fields and hides the Monthly Breakdown table.
- Graphs still show month-by-month bars in both monthly and yearly modes.
- Strengthened Taxable checkbox custom styling so the check mark is clearly visible.


V101 PDF ESCAPE + EXCEL EXPORT
------------------------------
- Fixed PDF export server error caused by missing pdfEscape/pdfSanitize/wrapPdfText helpers.
- Added styled Excel export endpoint: /admin/reports.xls.
- Reports page now includes Export Excel, Raw CSV, and Export PDF.
- Excel export uses an Excel-compatible styled HTML workbook with logo, summary cards, sales/profit charts, optional monthly breakdown, and invoice detail.
- Accountant email now includes CSV, Excel, and PDF attachments.


V102 ADMIN WORKFLOW REPAIR
--------------------------
- Restored missing Admin document functions that caused Create Quote, Create Invoice, Edit Quote, and Edit Invoice to fail.
- Restored document save/load/PDF/email helpers required by quote/invoice workflows.
- Restored missing EUFY Admin manager route handlers.
- Added Admin Home shortcut in the Admin top navigation.
- Admin server-error pages now stay inside the Admin Portal header/navigation instead of showing the public website header.
- Ran a static route-handler check and Node syntax check.


V103 LOGIN BUTTONS + SIGN UP
----------------------------
- Changed the login screen "Create Account" link to "Sign Up".
- Converted login-screen account links into professional button-style actions.
- Updated registration page heading and submit button from Create Account to Sign Up.
- Preserved all Admin workflow repairs from v102.


V104 DEPLOY DUPLICATE FIX
-------------------------
- Fixed Wrangler/esbuild deploy error caused by duplicate top-level PDF helper declarations: pdfSanitize, pdfEscape, and wrapPdfText.
- Kept the login screen Sign Up button styling from v103.
- Preserved Admin workflow repair, PDF/Excel report export, charts, fixed 10% tax, merchant applications, and mobile/admin styling.


V105 APPROVED QUOTE LIFECYCLE
-----------------------------
- Approved Quotes now show professional lifecycle status once converted to invoice.
- Converted quotes display the invoice number and whether that invoice is open or paid.
- If the linked invoice is paid, the Approved Quotes section shows "Invoice Paid" with payment method/date when available.
- Converted quote rows no longer show Cancel/Delete; they show protected record status instead.
- Added View Quote, View Invoice, Print Invoice, and Payment Details/Mark Invoice Paid actions where appropriate.


V106 PURPLE ADMIN TEMPLATE DASHBOARD
------------------------------------
- Rebuilt the Admin Dashboard using the provided Purple Admin dashboard template direction.
- Kept HB Commerce dark navy / neon orange / green theme.
- Customized the dashboard for HB Commerce workflows:
  quotes, invoices, online orders, merchant applications, EUFY/LTS managers, reports, paid/canceled records.
- Added Purple-style gradient KPI cards, sidebar command menu, workflow status panel, monthly sales/profit charts, and quick action cards.
- Preserved all existing Admin Portal functions and latest approved quote lifecycle behavior.


V107 PURPLE TEMPLATE TODO + EUFY/LTS THEME
------------------------------------------
- Reworked Admin Dashboard closer to the Purple Admin preview structure: sidebar, page header, three gradient KPI cards, sales chart, workflow/traffic panel, recent tickets table, recent updates, quick actions, and Todo List.
- Kept HB Commerce dark navy / neon orange / green theme.
- Added a local Admin Todo List with add/check/remove support using browser localStorage.
- Fixed EUFY and LTS Admin manager panels with full dark Admin theme styling for better left-list readability, product names, statuses, inputs, previews, and controls.
- Preserved all previous quote/invoice/report/application/order workflows.


V108 DASHBOARD STATUS + NOTIFICATIONS
-------------------------------------
- Removed the default Command Center table from the dashboard overview.
- Converted Recent Updates into a wide rectangle/table-style section matching the template direction while preserving HB Commerce dark theme.
- Added Status Progress panel next to Todo List for Online Orders, Quotes, Invoices, and Applications.
- Added Admin Notifications settings page with up to 5 phone numbers.
- Added phone notification triggers for quote approval, new online order, merchant application submission, quote/consultation request, merchant consultation request, and contact inquiry.
- SMS sending uses Twilio environment variables if configured: TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN, TWILIO_FROM_NUMBER.
- Added Notifications link in Admin nav/sidebar and quick actions.
- Reinforced EUFY/LTS manager left-panel readability.


V109 PRIVATE ADMIN SCROLL + PHONE FORMAT + SMS FIX
--------------------------------------------------
- Added independent scrolling for the Private Admin/sidebar section so it no longer depends on the full page scroll.
- Phone number fields in Notifications now auto-format as the admin types, e.g. (224) 555-1234.
- Notification backend normalizes saved numbers to E.164 format for SMS delivery.
- Test alert now gives clearer success/failure messages.
- SMS supports Twilio From Number or Twilio Messaging Service SID.
- Required Cloudflare env variables for SMS:
  TWILIO_ACCOUNT_SID
  TWILIO_AUTH_TOKEN
  TWILIO_FROM_NUMBER
  OR TWILIO_MESSAGING_SERVICE_SID


V110 SMS PROVIDER SETTINGS
--------------------------
- Added Twilio SMS provider fields directly inside Admin > Notifications:
  Twilio Account SID
  Twilio Auth Token
  Twilio From Number
  Twilio Messaging Service SID
- Save and Send Test Alert now can work after credentials are entered in Admin Portal, without needing immediate Cloudflare secret setup.
- Test alert now reports detailed Twilio delivery errors if SMS fails.
- Phone number auto-formatting remains active for recipient numbers and Twilio From Number.
- Independent Private Admin/sidebar scroll from v109 is preserved.


V111 FREE APP PUSH NOTIFICATIONS
--------------------------------
- Added no-cost Admin Portal app push notifications using the browser Push API / installed PWA service worker.
- Added /admin-push-sw.js service worker route.
- Added Admin > Notifications section: "Free App Push Notifications".
- Admin can enable push on the current phone/device and send a test app push.
- Event alerts now attempt app push first and optional SMS fallback second.
- SMS/Twilio remains optional only.
- App push notifications are generic alerts that open the Admin Portal; details are visible after opening the admin dashboard.


V112 PUSH-ONLY MOBILE TODO CALENDAR
-----------------------------------
- Removed SMS/Twilio setup from Admin > Notifications.
- Improved free app push notification delivery with fixed VAPID ES256 signature handling and broader Web Push headers.
- Admin > Notifications now focuses on installed app push notifications only.
- Added server-synced Todo List instead of browser-only localStorage.
- Added default "Follow up on Quote" task.
- Todo tasks now support due date/time and reminder minutes.
- Added calendar subscription feed at /admin/todos.ics?key=... so phone calendars can sync scheduled tasks and reminders.
- Added Calendar Sync links inside the Todo List card.
- Added stronger mobile responsive styling for the redesigned Admin Portal dashboard.


V113 MOBILE ADMIN + PUSH FIX
----------------------------
- Rebuilt stronger mobile CSS for the redesigned Admin Portal dashboard:
  sidebar becomes a compact mobile menu with independent scrolling,
  dashboard cards stack properly,
  tables/charts scroll horizontally,
  quick actions and todo/calendar panels fit phone screens better.
- Improved Web Push delivery by encrypting push payloads with aes128gcm Web Push encryption.
- Added payload parsing in the Admin push service worker.
- Added Local Test Notification button to verify that the device/browser can show notifications.
- Added clearer server push diagnostics.
- SMS/Twilio setup remains removed.


V114 MOBILE ADMIN KPI + PUSH REPAIR
-----------------------------------
- Added 4th dashboard KPI card: Monthly Sales.
- Added stronger phone-specific Admin Portal layout:
  compact sidebar menu, one-column KPI cards, smaller headers, cleaner cards,
  horizontal scrolling for charts/tables, and better quick action layout.
- Changed server app push to reliable no-payload VAPID push with generic secure alert.
- Enable App Push now resets the device subscription every time to avoid stale VAPID subscriptions.
- Notifications page now asks admin to use Local Test first, then Server Push Test.


V115 TODO DESCRIPTION INPUT FIX
-------------------------------
- Fixed the Todo List task-description input being too small.
- Task description now takes the full first row of the Todo form.
- Due date, reminder, and Add button sit below it cleanly.
- Improved task input font size, padding, visibility, and mobile layout.
- Preserved v114 Mobile Admin KPI and push-notification repair changes.


V116 TRUE MOBILE ADMIN VIEW
---------------------------
- Added final phone-specific CSS overrides to prevent the redesigned Admin Portal from overflowing on iPhone/mobile screens.
- KPI cards now use a compact 2-column mobile grid when possible.
- Quick Actions use compact 2-column mobile cards instead of huge single-column cards.
- Charts are contained within their panels with horizontal scrolling instead of clipping the whole page.
- Recent Updates table converts into mobile-friendly stacked cards.
- Workflow donut is hidden on mobile so the live count list is readable.
- Service worker is versioned, skipWaiting/clients.claim are enabled, and Enable Push unregisters stale admin push workers before re-subscribing.
- Preserved Todo List description input fix from v115.


V117 DESKTOP CHART LAYOUT CLEANUP
---------------------------------
- Removed the separate Gross Profit panel and moved Gross Profit by Month into the main Sales & Profit Statistics card.
- The main statistics card now contains Monthly Sales and Gross Profit by Month stacked together to use the previous blank space.
- Rebuilt the dashboard bar charts with crisp HTML/CSS chart styling: no rotated blurry labels, cleaner grid background, sharper bars, and improved responsive scrolling.
- Preserved v116 true mobile Admin view and push reset behavior.


V118 CHART CLIPPING FIX
-----------------------
- Fixed Sales & Profit Statistics charts where the bottom of the bars/month labels were getting cut off.
- Increased the internal chart area and reserved a dedicated row for month labels.
- Kept the charts as crisp HTML/CSS components.
- Preserved v117 combined sales/profit chart layout and all previous Admin Portal updates.


V119 WORKFLOW ACTIVE QUOTE COUNT FIX
------------------------------------
- Workflow Sources no longer counts quotes that were converted to invoices and then paid as active workflow.
- Approved Quotes section still retains those completed converted/paid quote records for audit/history.
- Status Progress quote row also excludes completed converted/paid quote records from active workflow progress.
- Approved Quotes lifecycle description clarifies that completed converted/paid quote records are history-only.
- Preserved v118 chart clipping fix and all previous Admin Portal updates.


V120 NATIVE iOS APNs SUPPORT
----------------------------
- Added native iOS device registration endpoint: POST /admin/ios-device/register.
- Added native iOS APNs test endpoint: POST /admin/ios-device/test.
- Existing admin events now try native iOS APNs push first and also keep web push fallback.
- Admin > Notifications now shows registered native iOS app device count and a Native iOS Test Push button.
- Required Cloudflare Worker secrets for native iOS push:
  APNS_KEY_BASE64
  APNS_KEY_ID
  APPLE_TEAM_ID
  IOS_BUNDLE_ID=com.hbcommerce.admin
  Optional APNS_ENV=production (default) or sandbox.


V121 HOMEPAGE EUFY DEAL BANNERS
-------------------------------
- Added a homepage eufy PoE NVR deal carousel built in HTML/CSS, not static mock banner images.
- Uses the current website logo from /assets/logo.png.
- Uses exact product image URLs from the eufy product records/product pages for:
  s4max-4-s4-addons
  s4max-2-s4-addons
  s4max-2-e40-addons
  e40-8-bullet
- No call-to-action buttons are placed on the banners.
- The full banner is clickable to the matching product page.
- Desktop banner sizing uses max-width 1680px and aspect-ratio 1680/792 to match the current homepage banner proportions.
- Preserved all v120 native iOS APNs Worker updates and previous Admin Portal/site changes.


V122 COMBINED HOMEPAGE BANNER SLIDER
------------------------------------
- Moved the new eufy deal banners into the main homepage banner slider instead of placing them underneath the current homepage banners.
- The combined homepage slider now includes:
  1) existing Home banner
  2) existing Merchant Services banner
  3) existing POS Software banner
  4) existing Security Camera Systems banner
  5) eufy S4 Max + 4 S4 Add-Ons deal
  6) eufy S4 Max + 2 S4 Add-Ons deal
  7) eufy S4 Max + 2 E40 Add-Ons deal
  8) eufy E40 8× 4K Bullet Cameras deal
- Slider auto-rotates every 5 seconds.
- No arrows were added.
- eufy slides use the current /assets/logo.png website logo and the exact matching product image URLs from the product records.
- Full slides are clickable to their matching product/solution pages.
- Preserved v121/v120 native iOS APNs and all previous website/admin updates.


V123 VISIBLE 8 HOMEPAGE BANNERS
-------------------------------
- Fixed the issue where the first 4 existing homepage banner slots were blank/not visible.
- The first 4 banners are now real HTML/CSS banner slides using current visible website assets:
  Home / Smart Solutions, Merchant Services, POS Software, Security Camera Systems.
- The 4 eufy product deal banners remain in the same slider.
- All 8 banner slots now have visible slide content.
- Slider still rotates every 5 seconds.
- No arrows were added.
- Existing homepage banner placeholders are no longer used for the first 4 slides.
- Preserved v122 combined slider, v121 eufy product matching, v120 native iOS APNs, and prior website/admin updates.


V125 HOMEPAGE BANNER SIZE REFINED
---------------------------------
- Based directly on v123 because v123 had the preferred banner design.
- Reduced the homepage banner desktop footprint without changing the banner ratio.
- New desktop banner max-width: 1520px instead of 1680px.
- Preserved the same 8-banner slider:
  1) Home / Smart Solutions
  2) Merchant Services
  3) POS Software
  4) Security Camera Systems
  5) eufy S4 Max + 4 S4 Add-Ons
  6) eufy S4 Max + 2 S4 Add-Ons
  7) eufy S4 Max + 2 E40 Add-Ons
  8) eufy E40 8× 4K Bullet Cameras
- Kept 5-second auto-slide timing.
- Kept no arrows.
- Kept the eufy banners and product-image matching from v123.
- Preserved all previous site/admin/iOS APNs updates in v123.


V126 BANNER TAX INVENTORY AUTOCOMPLETE
--------------------------------------
- Based directly on v125/v123 preferred homepage banner design.
- Reduced the banner footprint while preserving content visibility:
  smaller internal type/visual scaling, same ratio, no bottom clipping.
- Homepage banners remain HTML/CSS component banners. Product/solution images are used only as visual elements inside the banners.
- Fixed tax enforcement for product/security camera quote line items:
  camera/security products are treated as taxable and calculated at a flat 10%.
- Added Admin inventory autocomplete endpoint:
  GET /admin/inventory-search
- In Admin > Create Quote / Create Invoice:
  when Business = Security Camera Systems, Item Name now autocompletes from eufy/LTS inventory and camera-service sample items.
- Selecting an inventory item auto-fills:
  item name, description, listed sale price when available, cost when available, taxable status, and markup/margin calculations.
- If the inventory item has no listed price, fields remain editable so price/sale price/cost can be entered manually.
- Markup % auto-calculates from cost and sale price. Margin % is displayed in the calculated line summary.
- Preserved all previous Admin Portal, eufy product, homepage slider, and native iOS APNs updates from v125.


V127 EUFY TAX CART + LTS QUOTE ORDERS
-------------------------------------
- eufy product buttons now say "Add to Cart" instead of "Add to Quote Cart".
- LTS product buttons now remain "Add to Quote Cart".
- Website cart now shows Product Subtotal, Sales Tax (10%), and Estimated Total.
- eufy priced product checkout now clearly calculates fixed 10% tax on the website before submission.
- LTS quote-only products are submitted as Online Quote Orders instead of regular Online Orders.
- Added Admin route/page: /admin/quote-orders.
- Added Admin top-nav and dashboard quick action for Online Quote Orders.
- Online Orders remains for eufy priced product orders.
- Online Quote Orders is used for LTS/quote-only hardware requests so Admin can add pricing/costs and convert to a quote.
- Convert/cancel order workflow now supports both Online Orders and Online Quote Orders.
- Added checkout note that Authorize.Net card payment can be enabled later once API credentials are available.
- Preserved v126 homepage banners, fixed 10% admin tax, inventory autocomplete, and iOS APNs updates.


V128 CHECKBOX + CART + ACCOUNT + BANNER FIXES
---------------------------------------------
- Checkout "Shipping address same as billing" checkbox now displays compactly with the checkbox before the text.
- Top-right cart icon has stronger contrast, orange border/glow, and a clearly visible badge.
- When a customer is logged in, the header account icon changes into a visible user/profile icon.
- Clicking the logged-in account icon opens a dropdown with:
  My Account / Profile
  Change Password
  Log Out
- Added /account/profile route.
- Added /account/change-password page and secure password update workflow.
- My Account page now shows cleaner user profile/status information.
- Homepage banner vertical height reduced further while keeping internal content scaled to avoid clipping.
- Preserved v127 eufy tax cart, LTS quote orders, v126 inventory autocomplete, fixed 10% tax behavior, and native iOS APNs updates.


V129 CUSTOMER CHECKOUT CLEANUP
------------------------------
- Removed internal/customer-inappropriate checkout messages about Authorize.Net API credentials and Admin routing.
- Replaced customer checkout notices with clean customer-facing language only.
- Removed "Card coming soon" from the customer checkout payment choices.
- Removed "Admin → Online Quote Orders" wording from customer cart messages and confirmation dialogs.
- Fixed cart panel text readability on dark checkout screens:
  item names, prices, coupon text, cart heading, totals, and tax summary now use readable light colors.
- Reinforced compact "Shipping address same as billing" checkbox layout.
- Strengthened top-right cart icon visibility.
- Slightly reduced homepage banner vertical height again while keeping content scaled safely inside.
- Preserved v128 account dropdown/change password, v127 eufy tax cart/LTS quote orders, v126 inventory autocomplete, fixed 10% tax, and native iOS APNs updates.


V130 EUFY BANNER NO-CLIP FIX
----------------------------
- Based on v129.
- Fixed eufy homepage deal banners getting clipped at the bottom.
- Kept the v129 customer checkout cleanup, readable cart text, compact checkbox, cart icon/account menu, 10% tax workflow, LTS quote-order separation, inventory autocomplete, and iOS APNs work.
- Homepage slider now uses a safer 1680/735 desktop ratio and smaller centered eufy slide internals.
- eufy banner product images, price rows, coupon rows, bullet lists, and dots are scaled and positioned so no product/banner information should be cut off.
- Mobile/tablet fallback height was also increased slightly for the eufy slides to avoid clipping.


V131 FOOTER POLICIES ORDER HISTORY
----------------------------------
- Added a new ecommerce-style footer inspired by the provided reference screenshot.
- Footer now includes:
  INFORMATION: About Us, Contact, Delivery Information, Privacy Policy, Terms & Conditions, Returns.
  MY ACCOUNT: Sign In, Order History, Shopping Bag, My Account / Profile.
  SUPPORT: customer support note and Admin App link.
- Added new public pages:
  /delivery-information
  /privacy-policy
  /terms-and-conditions
  /returns
  /return-policy
- Returns page includes the requested 14-day return policy:
  products are refunded or replaced after inspection.
- Added /account/orders for customer Order History.
- Preserved v130 eufy banner no-clip fix, v129 checkout cleanup, v128 account dropdown/change password, v127 eufy tax cart/LTS quote orders, v126 inventory autocomplete, fixed 10% tax, and native iOS APNs work.


V132 FOOTER ADMIN LINK REMOVED
--------------------------------
- Removed the public Admin App button/link from the customer-facing website footer Support section.
- Added private convenience redirect links for owner/admin access:
  /hb-admin
  /admin-portal
  /owner-admin
  Each redirects to /admin-app. Bookmark one of these instead of exposing the Admin App button in the customer footer.
- Preserved v131 footer information/policy/order-history pages, v130 eufy banner no-clip fix, v129 checkout cleanup, v128 account dropdown/change password, v127 eufy tax cart/LTS quote orders, v126 inventory autocomplete, fixed 10% tax, and native iOS APNs updates.


V133 REFERENCE-SIZE BANNERS + HB THEME FOOTER
---------------------------------------------
- Based on v132.
- Reduced homepage banner vertical size to a more compact ecommerce/reference-style hero size.
- Preserved all 8 homepage slider banners and kept content scaled so eufy information does not cut off.
- Kept slider auto-rotation and no arrows.
- Changed the new footer from the reference-site brown/gold look to the HB Commerce theme:
  dark navy gradient, green/orange accents, light readable text, and matching hover states.
- Kept the INFORMATION and MY ACCOUNT footer link structure.
- Public footer still does not show the Admin App button.
- Hidden admin shortcuts from v132 remain available: /hb-admin, /admin-portal, /owner-admin.
- Preserved v131 policy pages/order history, v130 banner no-clip work, v129 checkout cleanup, v128 account menu/change password, v127 eufy tax cart/LTS quote orders, v126 inventory autocomplete, fixed 10% tax, and native iOS APNs updates.


V134 PROFESSIONAL INFORMATION PAGES + EMAIL PLACEMENT
-----------------------------------------------------
- Redesigned About, Delivery Information, Privacy Policy, Terms & Conditions, and Returns pages with a more professional ecommerce information-page layout inspired by the reference site, while keeping the HB Commerce navy/green/orange theme.
- Added a left Information sidebar, professional glass content card, highlighted info blocks, breadcrumb, and support contact block.
- Added correct email placement:
  General inquiries: info@hbcommercesolution.com
  Support, delivery, order, product, and return help: support@hbcommercesolution.com
- Updated footer to show both emails in the appropriate brand/support areas while keeping the HB Commerce theme.
- Updated Contact page side panel to show both General and Support emails.
- Preserved private admin shortcut routes and removed public Admin App button.
- Preserved v133 reference-size banners, v130 banner no-clip fix, v129 checkout cleanup, v128 account dropdown/change password, v127 eufy tax cart/LTS quote orders, v126 inventory autocomplete, fixed 10% tax, and native iOS APNs work.


V136 RESTORED PREVIOUS PUBLIC WEBSITE LAYOUT
--------------------------------------------
- Reverted the public website header/layout back to the previous HB Commerce layout used before the v135 professional ecommerce-style header experiment.
- Removed the v135-style top utility/search/center-logo header from the active package by returning to the v134 layout base.
- Preserved the v134 professional info pages and email placement:
  info@hbcommercesolution.com
  support@hbcommercesolution.com
- Preserved the footer/policy pages, return policy, order history, compact banners, eufy no-clip fix, checkout cleanup, account dropdown/change password, eufy tax cart, LTS quote orders, inventory autocomplete, fixed 10% tax, native iOS APNs, and private admin shortcuts.


Update in v137: Homepage banner slider resized to a shorter, wider reference-style proportion (1680x640) while keeping banner content fully visible.


V138 PROFESSIONAL MOBILE WEBSITE LAYOUT
---------------------------------------
- Added a mobile-specific responsive layout pass based on the organized mobile storefront approach from the reference site, while keeping HB Commerce branding, colors, logo, and existing elements.
- Mobile header is now sticky, compact, and organized with a clear menu button.
- Mobile menu opens into a professional dark navigation panel with Solutions, Products, Account, and Cart options.
- Homepage banners are now visible and organized on mobile instead of being hidden.
- Mobile banner content is stacked and scaled so text, prices, coupon information, and product images remain readable and not clipped.
- Homepage solution cards, footer, product grids, product detail pages, checkout, cart, account pages, and policy pages have improved phone-sized spacing and one-column layouts.
- Preserved v137 reference-height banners, v136 previous desktop layout, v134 professional info pages/emails, v130 eufy no-clip work, v127 cart/tax/LTS quote orders, v126 inventory autocomplete, fixed 10% tax, and native iOS APNs updates.


V139 QUOTE/INVOICE REGULAR PRICE DISPLAY
----------------------------------------
- Quote and invoice line items now display the regular sale price in the Unit Price column.
- Quote and invoice line totals now show the regular line total.
- If a line item has a discount, a clear line note shows the discount applied.
- The totals box now shows:
  Regular Subtotal
  Less Accumulated Line Discounts
  Subtotal After Discounts
  Taxable Subtotal
  Sales Tax
  Total
- PDF attachments generated from Save and Email now use the same regular-price display and bottom discount summary.
- Preserved all v138 mobile/professional layout updates and prior tax/cart/admin functionality.


V140 SHIPPING COST + QUOTE/INVOICE READABILITY
----------------------------------------------
- Fixed customer-facing quote/invoice text color visibility:
  prepared-for/prepared-by names, item quantities, line totals, and totals box values now use readable dark text.
- Kept regular sale price display from v139:
  line item Unit Price and Line Total show regular pricing, while accumulated line discounts appear in the totals section.
- Added a Shipping Cost field in Admin > Create/Edit Quote and Admin > Create/Edit Invoice.
- Shipping Cost is added to the final total but is non-taxable.
- Shipping Cost now appears in customer-facing quote/invoice totals and PDF attachments generated by Save and Email.
- Preserved all v139 and v138 website/admin/mobile functionality.


V141 DISCOUNTED PRICE COLUMN
----------------------------
- Quote and invoice tables now add a Discounted Price column only when at least one line item has a discount.
- If a line item has a discount:
  Unit Price is crossed out.
  Discounted Price shows next to it.
  Line Total is calculated from the discounted price.
- If no line items have discounts, the Discounted Price column is hidden completely.
- Removed the previous per-line discount note display from the quote/invoice table.
- PDF attachments generated from Save and Email now match the same conditional Discounted Price column behavior.
- Preserved v140 document readability fixes and non-taxable shipping cost field.


V142 ZIPTAX ILLINOIS DESTINATION TAX
------------------------------------
- Integrated ZipTax into Admin Portal quote/invoice tax lookup.
- New Admin Quote/Invoice behavior:
  - Tax Rate field is editable and saves with the document.
  - "Lookup Destination Tax" button calls a server-side ZipTax address-level lookup.
  - Illinois addresses automatically use ZipTax during ZIP/address lookup when state is IL.
  - ZipTax API key is never exposed to the browser.
- Required Cloudflare secret:
  npx wrangler secret put ZIPTAX_API_KEY
- ZipTax endpoint used:
  GET https://api.zip-tax.com/request/v60?address=<destination address>
  with header X-API-Key.
- If ZipTax is not configured or lookup fails, the document keeps the current/default tax rate and shows an Admin review message.
- Shipping remains non-taxable.
- Preserved v141 discounted-price column behavior, v140 shipping cost/readability fixes, and all previous website/admin/mobile functionality.


V143 AUTO ZIPTAX + TERMS + TEMPLATE PREVIEWS
--------------------------------------------
- Admin Quote/Invoice ZIP field now automatically runs city/state + destination tax lookup when a 5-digit ZIP is entered and the field loses focus / Tab is pressed.
- The ZIP lookup also runs after a short debounce once 5 digits are typed.
- Server-side tax lookup now trusts ZIP-derived city/state when the form still has the default state, so Illinois destination tax triggers automatically.
- Added Terms & Conditions field to Create/Edit Quote and Create/Edit Invoice.
- Terms & Conditions show in the customer quote/invoice and PDF generated by Save and Email.
- Added optional Invoice Payment Link field for future Authorize.Net payment links.
- If payment_link is entered on an invoice, the customer invoice shows a Pay Invoice Online link; the PDF also includes a clickable payment URL.
- Added Admin template visual preview page:
  /admin/invoice-templates
- Template preview page includes four visual samples:
  Template A — Modern HB Commerce
  Template B — Compact Retail / LTS Style
  Template C — Executive Security
  Template D — Minimal Accountant
- Active quote/invoice design was not changed yet; previews are for selecting the next design.
- Preserved v142 ZipTax integration, v141 discounted-price column behavior, v140 shipping cost/readability fixes, and all previous website/admin/mobile functionality.


V144 ACTIVE SIDEBAR QUOTE/INVOICE TEMPLATE
------------------------------------------
- Implemented the selected invoice/quote design as the active customer-facing HTML/CSS quote and invoice template.
- Left sidebar now uses HB Commerce branding with:
  75 LARCH CT., UNIT A, SCHAUMBURG, IL 60193
  229-485-6236
  info@hbcommercesolution.com
  www.hbcommercesolution.com
- Left sidebar now includes Other Payment Methods:
  CHECK — Hansabijal LLC
  ZELLE — paulcamerasystems@gmail.com
- Invoice template includes a disabled green PAY SECURE ONLINE / Authorize.Net placeholder section.
- Quote template replaces the secure payment section with APPROVE QUOTE and DECLINE QUOTE buttons that link to the existing approval/decline workflow.
- Terms & Conditions default text updated to the requested return/payment/security-camera wording.
- Kept v143 automatic ZipTax destination lookup, terms/payment-link fields, template preview page, v142 ZipTax integration, v141 discounted-price columns, and v140 shipping/readability fixes.


V145 EXACT TEMPLATE REFINEMENT
------------------------------
- Updated the active quote/invoice sidebar template to use the uploaded HB Commerce logo cropped to remove everything below the word SOLUTIONS.
- Rebuilt the Secure Payment section to more closely clone the approved design:
  green border, shield icon, centered title with divider lines, Authorize.Net placeholder button, and card marks.
- Rebuilt the left sidebar Other Payment Methods section to more closely match the approved image:
  green payment-method heading, green bordered card, CHECK/Hansabijal LLC, and ZELLE/paulcamerasystems@gmail.com.
- Rebuilt the bottom thank-you greeting line with left/right divider lines, green/orange stars, and script-style text.
- Kept the template as real HTML/CSS, not a flat image.
- Preserved all v144 quote/invoice behavior, v143 Auto ZipTax, template previews, terms/payment fields, and prior admin/website/mobile updates.


V146 FINE DETAIL TEMPLATE MATCH
-------------------------------
- Further refined the active quote/invoice sidebar template to match the provided screenshot areas more closely.
- Re-cropped the uploaded HB Commerce logo to include only the logo through SOLUTIONS, excluding the lower icon row and tagline.
- Replaced text-symbol icons with inline SVG icons for address, phone, email, website, prepared-by, bill-to, ship-to, terms, payment, and secure payment.
- Tightened sidebar spacing, icon circles, divider lines, blue/orange/green accents, and payment-method card styling.
- Refined Secure Payment section to better match the provided design: green shield, horizontal title lines, lock icon, disabled green Authorize.Net button, and card marks.
- Refined bottom thank-you line with divider lines, green/orange stars, and script-style message.
- All styling remains HTML/CSS/SVG, not a flat mock image.
- Preserved v145/v144 active template behavior, automatic ZipTax, terms/payment fields, and previous admin/site/mobile updates.


V147 EXACT PANEL + LOGO + SWOOSH REFINEMENT
-------------------------------------------
- Recreated the document logo for quotes/invoices using the uploaded HB mark plus HTML/CSS text for:
  HB COMMERCE
  SOLUTIONS
  with the white/green styling and letter spacing from the approved design.
- Added a stronger orange divider line between the blue sidebar and white document panel.
- Rebuilt the lower right orange/green sidebar swoosh curves so they visually match the approved invoice screenshot much more closely, especially around the Other Payment Methods section.
- Tightened the Other Payment Methods card styling, icon sizes, green border, text spacing, and dark-blue background.
- Refined Secure Payment and bottom thank-you sections while keeping them as HTML/CSS/SVG, not a flat image.
- Preserved v146 fine-detail SVG icons and all prior quote/invoice behavior, automatic ZipTax, terms/payment fields, and website/admin/mobile updates.


V152 V147 PAYMENT/LOGO/DIVIDER REFINEMENT
-----------------------------------------
- Based directly on the user-reverted v147 package.
- Updated the active quote/invoice template to use the newly provided HB Commerce logo in the left blue panel.
- Reworked the Secure Payment box so the Secure Payment title/line is centered, the green button is centered below it, and the card-brand marks are below the button.
- Reworked the left-panel/right-panel divider with a stronger orange vertical separator and larger green/orange curved swoosh design near the Other Payment Methods section.
- Kept the template built from HTML/CSS/SVG, not a flat image.
- Preserved v147 admin/site behavior, Auto ZipTax, quote approval/decline, shipping, discounts, terms, and all earlier admin portal functionality.


V154 ACTUAL USER DIVIDER APPLIED
--------------------------------
- Based on v152 / v147 deploy-safe template package.
- The divider image provided by the user was enhanced to 2x resolution and applied directly into the active quote/invoice template.
- Removed the previous CSS-generated divider/curve and replaced it with the actual supplied divider image asset.
- Moved the divider asset declaration before the CSS template so it renders correctly at runtime.
- Kept the correct HB Commerce logo in the quote/invoice template.
- Refined font weights and sizes closer to the attached invoice/quote reference.
- Worker raw size: 3061798 bytes, Cloudflare 3 MiB headroom: 83930 bytes.
- Node syntax check passed.


V155 VISIBLE DIVIDER + CUTOUT REFINEMENT
----------------------------------------
- Based on v154.
- Reprocessed the user-supplied divider image:
  - enhanced to 2x resolution
  - sharpened slightly
  - added white fill to the right side of the curve/line to remove the blue corner near the secure payment area
- Changed the divider implementation from a CSS pseudo-background to a real positioned <img> element inside the quote/invoice sidebar so the provided divider is visibly applied.
- Disabled the older CSS-generated pseudo divider/curve.
- Kept the correct HB Commerce logo.
- Kept the font refinements closer to the provided invoice/quote reference.
- Worker raw size: 3048823 bytes, Cloudflare 3 MiB headroom: 96905 bytes.
- Node syntax check passed.


V156 COMPACT LINE ITEMS + LOWER SECTION SPACING + PAYMENT ICONS
---------------------------------------------------------------
- Based on v155.
- Reduced Bill To / Ship To font sizes and adjusted their padding so customer information fits cleaner.
- Reduced quote/invoice item-table font sizes, row padding, and line heights so more line items fit more comfortably.
- Moved Terms & Conditions, totals, Secure Payment, and the thank-you line down to create more white space after the item table.
- Refined Check and Zelle payment method icon blocks with cleaner HTML/CSS/SVG styling while keeping the package deploy-safe.
- Kept the actual provided divider image, correct HB Commerce logo, auto ZipTax, discounted price behavior, shipping cost, quote approval/decline, and invoice payment placeholder.
- Worker raw size: 3053100 bytes, Cloudflare 3 MiB headroom: 92628 bytes.
- Node syntax check passed.


V157 LOWER SECTIONS + BILL/SHIP LABEL FIX
-----------------------------------------
- Based on v156.
- Fixed Bill To / Ship To overlap by increasing top padding inside the customer information cards while keeping smaller fonts.
- Moved the lower sections down:
  Terms & Conditions
  Totals
  Secure Payment / Quote Response
  Thank You message
- The lower content now uses remaining vertical space so it sits closer to the bottom of the document with about an inch of breathing room.
- Kept the compact item table font sizing so more quote/invoice line items can fit.
- Kept the actual divider image, correct HB Commerce logo, refined Check/Zelle icons, auto ZipTax, discounted price behavior, shipping cost, quote approval/decline, and invoice payment placeholder.
- Worker raw size: 3054397 bytes, Cloudflare 3 MiB headroom: 91331 bytes.
- Node syntax check passed.


V158 ADMIN USERS + ROLE PERMISSIONS
-----------------------------------
- Prepared By designation now shows Owner when the prepared-by name is Paul Patel; other names continue to show Account Manager.
- Added Admin Portal user management:
  /admin/users
  Fields: first name, last name, address, zipcode, city, state, phone, email, password, verify password, and role.
- Added Admin Portal role permission management:
  /admin/roles
  Roles: Admin, Manager, Employee.
  Permissions are managed by checkboxes for Dashboard, Quotes/Invoices, Orders, Quote Orders, Customers, Products, Applications, Reports, Notifications/Tasks, Tax, Users, and Roles.
- Admin role remains protected with full access to prevent lockout.
- Manager and Employee permissions can be checked/unchecked.
- Role permissions are enforced on Admin Portal routes.
- Added Users/Roles links to Admin Portal top navigation and dashboard quick actions.
- Uses existing D1 users table for login credentials and settings JSON for staff profiles/permissions, so no manual database migration is required.
- Preserved v157 invoice/quote layout fixes and all previous functionality.
- Worker raw size: 3066140 bytes. Cloudflare free-plan headroom: 79588 bytes.
- Node syntax check passed.


V159 ADMIN HEADER + SIDEBAR QUICK CREATE
----------------------------------------
- Removed the duplicate Admin Home link from the Admin Portal top header.
- Kept only the Dashboard link in the header because Dashboard and Admin Home went to the same page.
- Added Create Quote directly under Dashboard in the left/private admin sidebar.
- Added Create Invoice directly under Dashboard in the left/private admin sidebar.
- Styled the new sidebar create links so they are easy to see near the top without scrolling.
- Preserved v158 Admin Users + Role Permissions and all previous invoice/quote, ZipTax, website, and mobile updates.
- Worker raw size: 3066795 bytes. Cloudflare free-plan headroom: 78933 bytes.
- Node syntax check passed.


V160 ADMIN HEADER + ZIP RELOOKUP FIX
------------------------------------
- Removed the Templates link from the Admin Portal top header.
- ZIP lookup in Create/Edit Quote and Create/Edit Invoice now re-runs every time:
  - a 5-digit ZIP is typed
  - the ZIP field loses focus
  - Tab is pressed from the ZIP field
  - the ZIP field changes
- City and state are now overwritten from the latest ZIP lookup instead of keeping the previous city/state.
- Tax lookup is triggered again after each ZIP change, so the destination tax rate updates for the newly entered ZIP.
- Preserved v159 Admin sidebar Create Quote / Create Invoice quick links, Admin Users/Roles, and all previous invoice/quote/site/mobile functionality.
- Worker raw size: 3066710 bytes. Cloudflare free-plan headroom: 79018 bytes.
- Node syntax check and route-handler check passed.


V161 REMINDER EMAILS + PAYMENT LINK + PAID WATERMARK
----------------------------------------------------
- Added scheduled quote reminder emails:
  - Quotes send reminder emails during the final 3 days before the valid-until/expiry date.
  - After the quote date passes, a one-time expired email is sent and the quote status is set to Expired.
- Added scheduled invoice reminder emails:
  - Invoices send reminder emails during the final 2 days before the due date.
  - After the due date passes, overdue reminder emails state how many days past due the invoice is.
- Added Cloudflare cron trigger in wrangler.toml:
  crons = ["0 14 * * *"]
- Added manual admin test route:
  /admin/reminders/run
- Added Send Card Link button for unpaid/open invoices in the dashboard action row.
  This sends the saved Invoice Payment Link to the customer. If the invoice does not have a payment link, Admin is prompted to edit the invoice and add it first.
- Added diagonal PAID watermark in the center of paid invoices while keeping the existing paid status in the top-right.
- Reminder/payment emails require RESEND_API_KEY and customer email.
- For absolute approval/payment links in scheduled emails, set PUBLIC_BASE_URL to https://www.hbcommercesolution.com in wrangler.toml or Cloudflare vars.
- Preserved v160 ZIP rel-lookup, v159 sidebar quick create, Admin Users/Roles, invoice/quote design, ZipTax, and previous functionality.
- Worker raw size: 3076541 bytes. Cloudflare free-plan headroom: 69187 bytes.
- Node syntax check and route-handler check passed.


V162 WATERMARK SHIFT + REMINDER EMAIL LOGS
------------------------------------------
- Based directly on the uploaded v161 reminders/payment-link/paid-watermark package.
- Shifted the PAID watermark to the right side of the invoice template by moving it from 51% to 57% horizontal position.
- Added a new Admin Portal section:
  /admin/reminder-emails
- The Reminder Email Log shows emails sent for:
  quote expiry reminders,
  expired quotes,
  invoice due reminders,
  overdue invoice reminders,
  and card-payment link emails.
- Added an Email Log link to the Admin Portal top navigation.
- Added a Reminder Emails quick action card to the Admin dashboard.
- Reminder email sends are now logged into the settings table as JSON, so no manual database migration is required.
- Preserved v161 scheduled reminders, Send Card Link, paid watermark, v160 ZIP lookup fixes, v159 sidebar quick-create links, v158 user/role permissions, and prior invoice/quote design updates.
- Worker raw size: 3080577 bytes. Cloudflare free-plan headroom: 65151 bytes.
- Node syntax check and route-handler check passed.


V163 PAID WATERMARK CENTER + CHECK PAYMENT DETAILS
--------------------------------------------------
- Based on the uploaded v162 package.
- Moved the PAID watermark to the center of the white invoice panel instead of the full document.
- When marking an invoice paid with payment method Check, Admin is now asked for:
  Check Number
  Optional Check Image upload
- Check image is saved inside the invoice record as base64 in D1 data_json for internal reference.
- Added /admin/check-image?id=... so Admin can view the stored uploaded check image.
- Marking an invoice back to Open / Unpaid clears payment method, check number, and stored check image data.
- Added an on-page note that direct check deposit requires a bank-approved remote deposit capture / treasury API integration before it can be safely enabled.
- Preserved v162 reminder email logs, payment link, reminders, v161 reminder automation, v160 ZIP lookup fixes, v159 sidebar quick create, v158 users/roles, and all prior invoice/template/site/mobile updates.
- Worker raw size: 3085084 bytes. Cloudflare free-plan headroom: 60644 bytes.
- Node syntax check and route-handler check passed.


V164 DEPLOY FIX - DUPLICATE BYTESTOBASE64
-----------------------------------------
- Based directly on v163.
- Removed the duplicate top-level bytesToBase64() function declaration that caused Wrangler/esbuild to fail.
- Kept the existing original bytesToBase64() helper and reused it for check image upload storage.
- Preserved all v163 features:
  PAID watermark centered in the white invoice panel
  Check number + optional check image upload
  /admin/check-image secure view route
  Reminder email logs
  Reminder automation
  Send Card Link
  Admin Users/Roles
  ZIP relookup fix
  Sidebar Create Quote/Create Invoice
- Worker raw size: 3084943 bytes. Cloudflare free-plan headroom: 60785 bytes.
- Node syntax check and route-handler check passed.


V165 CLONE + POS SUPPORT BILLING SETUP
--------------------------------------
- Based on v164 deploy-fix package.
- Added Clone button between View and Email for:
  Approved quotes
  Open invoices
  Paid invoices
- Clone creates a new quote/invoice draft with:
  copied line items, pricing, business type, shipping, tax/terms/payment-link structure
  blank customer name/address/email/phone
  newly generated quote/invoice number
  unpaid/open status
- Added POS Support Billing section:
  /admin/pos-support
- POS Support Billing captures:
  business name, customer name, address, zip, city, state, phone, email,
  number of registers, bank account name, routing number, and bank account number.
- Monthly fee calculation:
  1 register = $40
  2 registers = $55
  3+ registers = $55 + $15 for each additional register
- For safety, the page stores bank account last 4 only until ACH/eCheck tokenization is connected.
- Added POS Support Billing link to the left admin sidebar and dashboard quick actions.
- Preserved v164 duplicate-base64 deploy fix, v163 check details/watermark, v162 email logs, v161 reminders/payment link/watermark, v160 ZIP lookup fix, v159 quick create, and all prior site/admin/mobile functionality.
- Worker raw size: 3093297 bytes. Cloudflare free-plan headroom: 52431 bytes.
- Node syntax check and route-handler check passed.


V166 CALENDAR SYNC + SEPARATE ADMIN PAGES + DASHBOARD CLEANUP
-------------------------------------------------------------
- Based on v165.
- Added a due-date calendar page: /admin/calendar.
- Added tokenized ICS calendar feed: /admin/due-dates.ics?key=... for quote expiration dates and open invoice due dates.
- Calendar page includes Google Calendar subscription link for paulcamerasystems@gmail.com workflow and a webcal link for PC/calendar apps.
- Changed left Private Admin links after Create Invoice to open their own pages for Quotes, Approved Quotes, Open Invoices, Paid Invoices, Status Progress, Todo List, and Calendar.
- Added back-arrow style header on those own pages.
- Removed the Quick Actions section from the dashboard because the same functions are now in Private Admin.
- Removed Status Progress and Todo List sections from the dashboard and moved them into their own Admin Portal popup-style pages.
- Kept Create Quote and Create Invoice as their own pages.
- Preserved v165 clone workflow, POS support billing setup, reminder/payment/watermark/check features from prior versions, and all website/mobile/admin updates.
- Worker raw size: 3105763 bytes. Cloudflare free-plan headroom: 39965 bytes.
- Node syntax check and route-handler check passed.


V167 GOOGLE CALENDAR PUBLIC ICS FIX
-----------------------------------
- Based on v166.
- Added a public tokenized calendar feed URL:
  /calendar/hb-due-dates-<token>.ics
- The old /admin/due-dates.ics?key=<token> feed still works for compatibility.
- The Admin Calendar page now uses the public tokenized feed for Google Calendar.
- Google Calendar link now opens the Add by URL settings page.
- ICS feed headers are more Google-friendly:
  text/calendar
  public cache for 5 minutes
  Access-Control-Allow-Origin: *
- Removed VALARM entries from the due-date ICS feed to keep the subscription feed simpler for Google Calendar.
- UID values are now sanitized to avoid strict parser issues.
- Added a Test / Open ICS Feed button and clearer manual instructions.
- Worker raw size: 3106548 bytes; Cloudflare free-plan headroom: 39180 bytes.
- Node syntax check and route-handler check passed.


V168 ADMIN CENTER LOGO + PRIVATE ADMIN SETTINGS
-----------------------------------------------
- Based on v167.
- Removed the top Admin Portal navigation buttons from the header.
- Centered the HB Commerce logo in the Admin Portal header.
- Added missing Admin Portal buttons into the Private Admin left panel:
  Quote Orders, Customers, Tax, Email Log, Users, Roles.
- Added Settings and Logout at the bottom of the Private Admin left panel.
- Added /admin/settings so the Private Admin sidebar button order can be reorganized without code changes.
- Added dashboard section order setting for: header, kpis, charts, recent.
- Preserved v167 Google Calendar feed fix and all prior quote/invoice, users/roles, POS billing setup, reminders, clone, and payment features.
- Worker raw size: 3111446 bytes. Cloudflare free-plan headroom: 34282 bytes.
- Node syntax check and route-handler check passed.


V169 DRAG-AND-DROP ADMIN LAYOUT ORGANIZER
-----------------------------------------
- Based on v168.
- Replaced the text/key-based Admin Layout Settings page with a drag-and-drop organizer.
- In /admin/settings, Admin can now drag Private Admin buttons up/down and save the order.
- Admin can also drag main dashboard sections up/down and save the order.
- Removed the need to type keys manually.
- Preserved v168 centered Admin header logo, Private Admin button changes, Google Calendar feed fix, reminder email logs, clone workflow, POS support billing setup, users/roles, ZIP tax lookup, invoice template updates, and all prior features.
- Worker raw size: 3114382 bytes. Cloudflare free-plan headroom: 31346 bytes.
- Node syntax check and route-handler check passed.


V170 ADMIN LAYOUT COLORS + LOGIN LOGO
-------------------------------------
- Based on v169.
- Added color controls to /admin/settings:
  - Private Admin Button Color
  - Private Admin Font Color
- Color changes are saved and applied to the Private Admin left-panel buttons.
- Replaced the Admin Portal login screen logo with the new embedded HB Commerce logo already used in the Admin header/template.
- Kept drag-and-drop sidebar and dashboard section organizer.
- Preserved v169/v168 and all previous quote/invoice, Google Calendar, reminder, POS support, user/role, ZIP lookup, check image, and template updates.
- Worker raw size: 3115874 bytes. Cloudflare free-plan headroom: 29854 bytes.
- Node syntax check and route-handler check passed.


V171 PRIVATE ADMIN FONT COLOR FIX
---------------------------------
- Based on v170.
- Fixed /admin/settings font color behavior for Private Admin buttons.
- Font color now changes the button text labels only.
- Button icons keep their original icon styling/color instead of changing with the font color picker.
- Button background color still changes the Private Admin button background.
- Kept the Admin login screen logo update, drag-and-drop organizer, dashboard layout organizer, and all prior Admin Portal / quote / invoice features.
- Worker raw size: 3116172 bytes. Cloudflare free-plan headroom: 29556 bytes.
- Node syntax check and route-handler check passed.


V173 AUTHORIZE.NET ACCEPTUI INVOICE PAYMENTS
--------------------------------------------
- Replaced the external Accept Hosted redirect flow with Authorize.Net AcceptUI hosted card-entry popup.
- This avoids the blank external accept.authorize.net Order Summary page issue.
- Customer stays on the HB Commerce invoice payment page, clicks Pay, enters card details in Authorize.Net's secure hosted popup, and the Worker charges the one-time nonce.
- Added required Cloudflare secret:
  AUTHORIZE_NET_PUBLIC_CLIENT_KEY
- Existing required secrets:
  AUTHORIZE_NET_API_LOGIN_ID
  AUTHORIZE_NET_TRANSACTION_KEY
- AUTHORIZE_NET_ENV remains optional; leave unset for production, set to sandbox only for sandbox credentials.
- Successful card payments mark the invoice paid, store payment_method Credit Card, and save Authorize.Net transaction/auth details.
- Admin Send Card Link now sends the generated /pay/invoice/<id>/<token> URL instead of requiring a manually pasted payment link.
- Preserved v171 and all prior Admin Portal, quote/invoice, reminder, calendar, user/role, ZIP lookup, and template features.
- Worker raw size: 3125408 bytes. Cloudflare free-plan headroom: 20320 bytes.
- Node syntax check and route-handler check passed.


V174 BRANDED CUSTOMER PAYMENT PAGE + SECRET GUIDANCE
----------------------------------------------------
- Based on v173.
- Improved the customer invoice payment page with an HB Commerce themed payment screen:
  HB Commerce logo, dark navy/green/orange theme, invoice summary, total due panel, secure card payment panel, card brand marks, and back-to-invoice button.
- The Authorize.Net AcceptUI popup still collects card data directly through Authorize.Net; HB Commerce does not store card numbers.
- After approval, the invoice is automatically marked paid and the existing paid watermark appears on the invoice.
- No API credentials are hardcoded in worker.js. Continue using Cloudflare Worker secrets:
  AUTHORIZE_NET_API_LOGIN_ID
  AUTHORIZE_NET_TRANSACTION_KEY
  AUTHORIZE_NET_PUBLIC_CLIENT_KEY
- Cloudflare Worker secrets persist across normal wrangler deploys; they do not need to be re-entered unless deleted, renamed, moved to a different Worker/project/account, or regenerated in Authorize.Net.
- Worker raw size: 3129161 bytes. Cloudflare free-plan headroom: 16567 bytes.
- Node syntax check and route-handler check passed.


V175 PAYMENT CURSOR FIX
-----------------------
- Based on v174.
- Fixed the invoice template PAY SECURE ONLINE button cursor.
- The active invoice payment link now uses a normal pointer cursor and remains clickable.
- Paid invoices still show the disabled PAID button with the not-allowed cursor.
- Preserved v174 branded payment page, Authorize.Net AcceptUI, Admin layout settings, and all prior features.
- Worker raw size: 3129404 bytes. Cloudflare free-plan headroom: 16324 bytes.
- Node syntax check and route-handler check passed.


V176 UNIFIED DOCUMENT EMAIL + PRINT FIX
---------------------------------------
- Based on v175.
- Fixed the major mismatch between Admin View, emailed invoice/quote, and Print/Save PDF.
- Document email no longer attaches the old manually generated PDF template.
- Email now sends the secure live invoice/quote link, so customers see the same design as Admin View.
- Invoice emails include Pay Secure Online and View Invoice buttons.
- Quote emails include Approve Quote and Decline Quote buttons.
- Removed the unused old manual invoice/quote PDF builder from worker.js.
- Added strong print CSS so Print / Save PDF from the live review page uses the same invoice/quote design and is scaled to fit on Letter page where possible.
- Browser print headers/footers may still need to be turned off in the browser print dialog for a perfectly clean PDF.
- Preserved v175 branded payment page, Authorize.Net AcceptUI, Admin layout settings, and all prior features.
- Worker raw size: 3119885 bytes. Cloudflare free-plan headroom: 25843 bytes.
- Node syntax check and route-handler check passed.


V177 EXACT ONE-PAGE PRINT LAYOUT FIX
------------------------------------
- Based on v176.
- Fixed Print / Save PDF so the live invoice/quote keeps the desktop layout instead of switching to the mobile/stacked layout.
- Forces Bill To and Ship To to stay side-by-side in print.
- Forces Terms/Conditions and totals to stay side-by-side in print.
- Forces Secure Payment to keep the designed horizontal layout in print.
- Scales the 1080px document to fit a Letter-size print page.
- Preserves v176 email behavior: customer emails send the live invoice/quote link instead of the old PDF attachment.
- For the best browser PDF result, use Destination: Save as PDF, Margins: None, and enable Background graphics.
- Worker raw size: 3122902 bytes. Cloudflare free-plan headroom: 22826 bytes.
- Node syntax check and route-handler check passed.


V178 PRINT MATCHES VIEW + DIVIDER FIX
-------------------------------------
- Based on v177.
- Fixed Print / Save PDF layout so the invoice/quote keeps the same desktop design as Admin View.
- Changed print scaling from CSS transform to Chrome-supported zoom so the element occupies the scaled page space instead of spilling onto a second page.
- Forced the left panel divider image to remain visible in print:
  orange vertical line and orange/green curved divider are printed from the actual image element.
- Forced Bill To / Ship To, lower totals, and secure payment layout to stay in the designed two-column/horizontal format.
- Customer emails still send the live document link so customers view the same design instead of the old PDF attachment.
- Recommended print settings: Save as PDF, Margins None, Background graphics ON, Headers and footers OFF.
- Worker raw size: 3126620 bytes. Cloudflare free-plan headroom: 19108 bytes.
- Node syntax check and route-handler check passed.


V181 V178-BASE BANNER POSITION + ZIPTAX EUFY CARD CHECKOUT
----------------------------------------------------------
- Built from v178 as requested.
- Homepage Merchant Services, POS Software, and Security Camera Systems banner slides:
  - moved only the left-side copy block upward
  - did not enlarge fonts
  - did not move or resize right-side images
- eufy checkout updates:
  - priced eufy products remain Add to Cart / Checkout
  - checkout now offers Credit Card, Check, and Zelle
  - Credit Card orders redirect to the Authorize.Net secure payment flow after order submission
  - successful card payments mark the online order paid
  - Check/Zelle orders stay as Online Orders in Admin Portal for follow-up
- Website checkout tax:
  - ZipTax is used to calculate destination sales tax from shipping address/ZIP when available
  - if ZipTax is unavailable or not configured, checkout falls back to the existing 10% fixed tax behavior
- Admin Online Orders text/tax labels were updated to no longer say fixed 10%.
- Preserved v178 invoice/quote print/divider behavior and all previous Admin Portal functionality.
- Worker raw size: 3129864 bytes. Cloudflare free-plan headroom: 15864 bytes.
- Node syntax check and route-handler check passed.


V182 V181 LOGO RESTORED EVERYWHERE
----------------------------------
- Based on v181 so the corrected banner movement, ZipTax eufy checkout tax, and eufy credit card/check/Zelle checkout are preserved.
- Restored the newly uploaded HB Commerce logo across:
  - website header
  - website footer
  - homepage/current/eufy banner logos
  - Admin Portal centered header
  - Admin login screen
  - quote/invoice template
  - branded payment page
- Added a versioned logo route for cache busting:
  /assets/logo-v182.webp
- Kept /assets/logo.png as a compatibility route.
- Worker raw size: 3136891 bytes. Cloudflare free-plan headroom: 8837 bytes.
- Node syntax check and route-handler check passed.


V183 HOMEPAGE BANNER RIGHT-SIDE IMAGE INTEGRATION
-------------------------------------------------
- Based on v182.
- Keeps all v182 logo updates everywhere.
- Keeps all v181 eufy checkout / ZipTax / Credit Card / Check / Zelle updates.
- Refines only the right-side image placement on homepage banners:
  - Merchant Services
  - POS Software
  - Security Camera Systems
  - All 4 eufy camera banners
- Left-side text, logo placement, and font sizes were not changed.
- Right-side images now fill the right visual half more naturally with an integrated branded glow panel.
- Images use object-fit: contain so product/visual details are not cropped.
- Worker raw size: 3139526 bytes. Cloudflare free-plan headroom: 6202 bytes.
- Node syntax check and route-handler check passed.


V184 EUFY CHECKOUT + MOBILE INVOICE REFINEMENTS
-----------------------------------------------
- Based on v183.
- eufy product/card readability:
  - fixed hard-to-read dark price/text colors on eufy product cards.
  - kept coupon and sale-price badges readable on the dark theme.
- Cart / checkout visual refinements:
  - improved cart line item cards.
  - improved checkout grid/card layout.
  - improved payment method selection styling.
- Credit card checkout:
  - selecting Credit Card now opens a secure card-entry section directly under the payment method.
  - card data is tokenized in the browser by Authorize.Net Accept.js.
  - HB Commerce does not store raw card numbers.
  - the same Place Order button becomes Pay & Place Order for credit card.
  - successful card payment saves the Online Order as Paid Online in Admin.
  - Check/Zelle still submits as Online Order for Admin follow-up.
- Checkout tax:
  - preserves ZipTax destination tax flow from v181/v183.
- Homepage compliance block:
  - restyled and centered the Compliant / Certified / Trusted block so it looks like a professional trust strip instead of an awkward standalone section.
- Mobile Admin invoice view:
  - invoice/quote view keeps the full desktop invoice canvas available on mobile, with horizontal scroll instead of stacking into a broken mobile layout.
- Print / Save PDF:
  - tightened print scaling and spacing to better keep one-page invoices together when the browser print dialog uses proper settings.
  - For best print: Margins None, Background graphics ON, Headers/Footers OFF.
- Preserved v183 banner image integration and v182 logo restoration.
- Worker raw size: 3143718 bytes. Cloudflare free-plan headroom: 2010 bytes.
- Node syntax check and route-handler check passed.


V185 CART / CHECKOUT SHIPPING + PICKUP + UPS RATE UI
----------------------------------------------------
- Based on v184.
- Preserves:
  - uploaded HB Commerce logo across website/admin/template
  - v183 homepage banner right-side image integration
  - eufy checkout direct Authorize.Net card tokenization
  - ZipTax destination tax calculation
  - Check/Zelle orders going to Admin Online Orders
  - mobile invoice and print refinements from v184
- Cart/checkout layout:
  - improved cart line item structure for a cleaner ecommerce-style cart
  - added shipping line to the cart totals panel
  - improved delivery method and payment method visual selection
- Checkout fulfillment:
  - customer can choose Shipping or Pickup
  - Pickup sets shipping cost to $0 and hides the shipping address block
  - Shipping keeps shipping address fields required
- UPS-style rate integration:
  - added /api/shipping/rate
  - if UPS credentials are configured, checkout requests an UPS Ground rate based on destination ZIP
  - if UPS credentials are not configured or UPS fails, checkout falls back to STANDARD_SHIPPING_FALLBACK, defaulting to $0 with Admin review
- Order records:
  - stores fulfillment_type
  - stores shipping_service
  - stores shipping_cost
  - card checkout charges subtotal + ZipTax tax + shipping
  - Check/Zelle online orders include shipping/tax info for Admin follow-up
- Size optimization:
  - de-duplicated embedded logo base64 to recover worker size headroom.
- Required optional UPS secrets:
  UPS_CLIENT_ID
  UPS_CLIENT_SECRET
  UPS_ACCOUNT_NUMBER
  UPS_ORIGIN_ZIP
  STANDARD_SHIPPING_FALLBACK
  UPS_ENV=sandbox only for UPS sandbox testing
- Worker raw size: 3103134 bytes. Cloudflare free-plan headroom: 42594 bytes.
- Node syntax check and route-handler check passed.


V187 REBUILT PROFESSIONAL CART/CHECKOUT + UPS DIAGNOSTIC
--------------------------------------------------------
- Based on v185, not v186, to avoid oversized checkout elements.
- Rebuilt cart CSS layout:
  - product list on left
  - professional sticky order summary on right
  - cleaner product rows with better image/title/price/quantity/remove spacing
- Rebuilt checkout CSS layout:
  - checkout form on left
  - sticky order summary on right
  - normal 100% browser scale sizing, not enlarged due to zoom misunderstanding
  - compact input heights, labels, radio cards, delivery method, and payment method sections
- Preserved shipping/pickup logic:
  - Shipping requires address
  - Pickup hides shipping address and uses $0 shipping
- UPS improvements:
  - added transaction headers to UPS OAuth/rating requests
  - customer no longer sees raw UPS errors such as Invalid Authentication Information
  - added admin-only UPS test route: /admin/ups-test?zip=60123
- Important: UPS Invalid Authentication Information is a credential/environment/API-access issue. Use /admin/ups-test after setting UPS secrets.
- Preserved:
  - uploaded HB Commerce logo everywhere
  - v183 banner image integration
  - ZipTax destination tax
  - direct Authorize.Net tokenized card checkout
  - Check/Zelle Online Orders
- Worker raw size: 3114362 bytes. Cloudflare free-plan headroom: 31366 bytes.
- Node syntax check and route-handler check passed.


V188 PROFESSIONAL CART/CHECKOUT + STRICT UPS RATES
--------------------------------------------------
- Based on v187.
- Keeps rebuilt professional cart and checkout layouts with normal 100% sizing.
- UPS shipping is strict by default: checkout requires a live UPS rate for Shipping.
- Customer no longer gets standard fallback shipping unless ALLOW_STANDARD_SHIPPING_FALLBACK=1 is explicitly set.
- If UPS cannot authenticate/rate, the checkout tells customer to choose Pickup or contact HB Commerce while UPS API is fixed.
- Added /admin/ups-test?zip=60123 to diagnose UPS credentials/API access without exposing secrets.
- Worker raw size: 3115052 bytes. Cloudflare free-plan headroom: 30676 bytes.
- Node syntax check and route-handler check passed.


V189 LIGHT PROFESSIONAL CART/CHECKOUT + UPS DIAGNOSTIC
------------------------------------------------------
- Based on v188.
- Reworked cart and checkout visually with a lighter, professional ecommerce-style theme while preserving HB Commerce navy/orange/green branding.
- Cart now has a clean product list and sticky order summary on desktop.
- Checkout now has white card sections, cleaner fields, compact delivery/payment option cards, and a professional order summary.
- This is CSS/UX only for the cart/checkout layout; payment, ZipTax, and UPS logic remain intact.
- UPS admin test now clearly warns when UPS_ENV is set to sandbox and gives the exact command to delete it for production credentials.
- Live UPS rates are still required when customer selects Shipping.
- Worker raw size: 3125458 bytes. Cloudflare free-plan headroom: 20270 bytes.
- Node syntax check and route-handler check passed.


V190 REAL ECOMMERCE CART/CHECKOUT + UPS FIX
-------------------------------------------
- Based on v189.
- Rebuilt cart structure with a real product-list + sticky order-summary layout.
- Rebuilt checkout form into a step-based ecommerce checkout:
  1. Contact information
  2. Coupon
  3. Billing address
  4. Delivery method / shipping address
  5. Payment method / card fields
- Fixed text contrast issues caused by old dark-theme CSS overriding light cart/checkout pages.
- Keeps HB Commerce navy, orange, and green theme while using a lighter ecommerce background.
- Keeps direct Authorize.Net card tokenization from checkout.
- Keeps Check/Zelle online order flow.
- Keeps ZipTax destination tax.
- UPS fix:
  - UPS_ENV is now ignored so an accidental sandbox secret will not force sandbox mode.
  - Production is used by default.
  - Sandbox is used only if UPS_FORCE_SANDBOX=1 is set.
  - UPS errors now state whether OAuth failed before rating or Rating failed after OAuth succeeded.
  - Admin UPS test now shows which required secrets are present/missing.
  - Admin UPS test explains that the UPS Developer App must have Rating API access, not only Shipping.
- Worker raw size: 3135765 bytes. Cloudflare free-plan headroom: 9963 bytes.
- Node syntax check and route-handler check passed.


V191 PREMIUM CART/CHECKOUT + UPS REVIEW
---------------------------------------
- Based on v190.
- Rebuilt cart and checkout markup again, not just colors.
- Cart:
  - premium ecommerce-style layout with product list and sticky order summary.
  - clearer product row with image, name, price, coupon, qty, line total, and remove button.
  - uses HB Commerce homepage-style light gradient background and high-contrast card text.
- Checkout:
  - rebuilt into step cards for Contact, Coupon, Billing, Delivery, and Payment.
  - right-side order summary contains mini product rows and totals.
  - delivery method remains Shipping / Pickup.
  - credit card form remains inline and tokenized via Authorize.Net.
- UPS:
  - preserved strict UPS diagnostics from v190.
  - callback URL is not required for OAuth client-credentials flow used by this Worker.
  - if UPS test fails at OAuth, check the actual Cloudflare secrets and whether the UPS app credentials are production credentials.
- Worker raw size: 3137606 bytes. Cloudflare free-plan headroom: 8122 bytes.
- Node syntax check and route-handler check passed.


V192 TRUE PREMIUM ECOMMERCE CART / CHECKOUT REBUILD
---------------------------------------------------
- Based on v191.
- Rebuilt the cart and checkout markup again instead of just changing colors.
- Cart now uses a modern ecommerce structure:
  - homepage-style light gradient background
  - large product list panel
  - individual product cards with image, name, unit price, coupon, quantity, line total, and remove button
  - sticky right-side order summary
  - high-contrast text/colors
- Checkout now uses a modern ecommerce structure:
  - homepage-style light gradient background
  - compact checkout hero
  - customer, coupon, billing, delivery, and payment cards
  - sticky order summary on the right
  - high-contrast readable fields and labels
- Delivery options:
  - UPS Ground live rate
  - Pickup
  - FedEx placeholder / coming soon section for later API integration
- Preserves UPS functionality from v191, which the user confirmed is working.
- Preserves ZipTax, Authorize.Net tokenized card checkout, Check/Zelle workflow, uploaded logo, invoice/quote and admin features from prior versions.
- Removed superseded v189/v191 cart CSS blocks to prevent conflicts and recover Worker size.
- Worker raw size: 3132639 bytes. Cloudflare free-plan headroom: 13089 bytes.
- Node syntax check and route-handler check passed.


V193 ADD-TO-CART + UPS RATE + HOMEPAGE THEME DOWNLOAD FIX
----------------------------------------------------------
- Based on v192.
- Fixed eufy Add to Cart by allowing products to be added to localStorage cart without requiring account status first. Checkout still requires a verified customer account.
- Added safer Add to Cart button handling on product cards and product detail pages.
- Improved UPS checkout behavior: UPS is no longer called before the customer enters a complete ZIP code, so the page does not show premature UPS errors.
- Keeps live UPS rating required for shipping once a ZIP/address is entered.
- Keeps Pickup option at $0 shipping.
- Keeps ZipTax destination sales tax and Authorize.Net card tokenization.
- Added downloadable homepage background theme CSS as a file in the ZIP and as a live route: /assets/hb-homepage-background-theme.css
- Re-applied homepage background gradients to cart/checkout pages while forcing high-contrast text colors.
- Worker raw size: 3134968 bytes. Cloudflare free-plan headroom: 10760 bytes.
- Node syntax check and route-handler check passed.


V197 DEPLOY FIXED CART + SAME ADDRESS + FEDEX
--------------------------------------------
- Based on v193, the last version with fixed Add to Cart direction and homepage-theme cart/checkout work.
- Fixes the Cloudflare build failure from v194/v195/v196 by inserting FedEx after the complete upsGroundRate function instead of inside the UPS function signature.
- Validated with esbuild bundling to catch the exact parser error Wrangler was reporting.
- Add to Cart buttons now use data attributes plus a delegated click listener to avoid inline-handler/button nesting issues.
- Shipping address same as billing now copies billing street/city/state/ZIP immediately and keeps copying if billing fields are edited while the box is checked.
- Cart/checkout use the exact homepage background gradient and readability overrides.
- Delivery Method now includes UPS Ground, FedEx Ground, and Pickup.
- Added FedEx Ground live rate lookup and /admin/fedex-test?zip=60123.
- Preserved UPS, ZipTax, Authorize.Net card tokenization, and Admin Portal features.
- Worker raw size: 3142187 bytes. Cloudflare free-plan headroom: 3541 bytes.
- esbuild syntax/bundle check and route-handler check passed.


V198 V197 DESIGN + BUTTON/CHECKBOX/FedEx FIX
--------------------------------------------
- Based on v197 so the cart and checkout page layout/design from v197 stays in place.
- Fixed the actual runtime JavaScript syntax error inside eufyStoreScript that was preventing Add to Cart, cart rendering, and checkbox behavior from running.
- Restored Add to Cart button behavior using the working v189 style direct button calls for eufy product cards and product detail pages.
- Restored Add to Quote Cart behavior for LTS item/detail pages.
- Restored same-as-billing copy behavior using the v189 function and added listeners so the shipping address updates when the checkbox is selected.
- Kept the v197 cart/checkout markup and visual layout; only the broken cart script/functionality was corrected.
- Kept homepage-background styling for cart and checkout with readable text overrides.
- Kept UPS working and kept FedEx live rate code + /admin/fedex-test?zip=60123 from v197.
- Runtime script check for eufyStoreScript passed. This catches the browser-side cart script error that normal node --check does not catch.
- Worker raw size: 3144268 bytes. Cloudflare free-plan headroom: 1460 bytes.
- Node syntax check, eufy runtime script syntax check, and route-handler check passed.


V199 CART/CHECKOUT HOMEPAGE BACKGROUND + LATEST INVOICE BALANCE TOTAL
--------------------------------------------------------------------
- Based on v198, preserving the now-working Add to Cart / Add to Quote Cart and same-as-billing checkbox behavior.
- Forces the exact homepage background theme onto cart and checkout pages using an in-page CSS override:
  radial orange glow, radial green glow, and light green/white gradient.
- Adds high-contrast text overrides for cart/checkout so the text stays readable on the homepage-style background.
- Adds customer open-invoice balance logic:
  - if a customer has more than one open invoice,
  - only the latest-created open invoice for that customer shows an extra line under TOTAL DUE,
  - the line is BALANCE TOTAL and includes the total of all open invoices for that customer.
- Customer matching uses email first; if email is missing, it falls back to customer name.
- Older open invoices for that customer do not show the balance line.
- Stripped code comments from worker.js to regain Cloudflare free-plan size headroom.
- Worker raw size: 3134223 bytes. Cloudflare free-plan headroom: 11505 bytes.
- Node syntax check and route-handler check passed.


V200 BALANCE TOTAL PAYMENT FIX
------------------------------
- Based on v199.
- Keeps the working cart/checkout homepage background and latest-invoice BALANCE TOTAL display.
- Fixes the Pay Secure Online flow for customers with multiple open invoices:
  - the latest open invoice for a customer shows BALANCE TOTAL under TOTAL DUE.
  - the payment page now also shows BALANCE TOTAL.
  - the Authorize.Net charge amount uses BALANCE TOTAL instead of only that invoice total.
  - after a successful balance payment, all included open invoices for that customer are marked Paid.
- Older open invoices for the same customer still pay only their own invoice amount unless they are included in the latest invoice balance payment.
- Customer matching uses email first, then customer name fallback.
- Worker raw size: 3136444 bytes. Cloudflare free-plan headroom: 9284 bytes.
- Node syntax check and route-handler check passed.


V201 AUTHORIZE.NET AUTH DIAGNOSTICS
-----------------------------------
- Based on v200.
- Added admin-only Authorize.Net test page: /admin/authnet-test.
- The test page verifies the server-side API Login ID + Transaction Key against the selected Authorize.Net endpoint without charging a card.
- Payment pages now show Authorize.Net AcceptUI error codes such as E_WC_21 / E_WC_19 instead of only the plain text message.
- AUTHORIZE_NET_ENV is now trimmed and accepts sandbox/test/testing/apitest as sandbox aliases; production remains the default when unset.
- Worker raw size: 3140296 bytes. Cloudflare free-plan headroom: 5432 bytes.
- Node syntax check passed.


---

## v204 visual contrast update

Create Quote and Create Invoice now include a page-level checkout-style contrast override. The form background uses the secure checkout navy theme, while inputs/selects/textareas use high-contrast white fields with dark text so values remain readable in Chrome, Edge, Safari, and mobile browsers.

---

## v205 live ZipTax + checkout payment notices update

- Billing ZIP on Create Quote / Create Invoice now performs a live city/state lookup and automatically applies destination sales tax from ZipTax without clicking the destination-tax button.
- Changing the billing ZIP again triggers a fresh lookup and updates the tax rate from the new ZIP.
- Shipping ZIP still performs live destination tax lookup and auto shipping rate calculation.
- Checkout payment method section now shows black-background instructions when the customer selects Check or Zelle.
- Check instructions tell the customer to make the check out to HANSABIJAL LLC and message a copy of the check to 229-485-6236.
- Zelle instructions show PAULCAMERASYSTEMS@GMAIL.COM and the requested payment-email disclaimer.
- Place Order / Pay & Place Order now shows an OK-only final-sale notice before the order/payment submission continues.
- The final-sale notice acknowledgement is stored inside the online order JSON and is shown in the Admin Online Order detail view.
- No database migration required.

---

## v206 checkout modal + PDF quote/invoice email update

- Place Order final-sale notice now uses an in-website modal window with an OK button instead of the browser alert box.
- Admin Quote / Invoice PDF download routes are wired at /admin/document.pdf?id=... and /review/{id}/{token}.pdf.
- Quote, invoice, and invoice payment-link emails now use the updated HB Commerce email design and attach a generated PDF copy of the quote or invoice.
- PDF filenames are generated safely from the document type and number.
- Billing ZIP live lookup from v205 remains active: changing the billing ZIP triggers city/state lookup and destination tax refresh.
- No database migration required.

v211 update - canonical one-page invoice/quote PDF divider fix
- Restored the customer email flow to the one-page PDF invoice/quote design instead of using the webpage as the primary customer view.
- Email view links with ?email_view=1 now redirect directly to the one-page PDF for phone, tablet, and desktop.
- The PDF sidebar now uses the uploaded HB divider artwork, flattened over the navy sidebar and cleaned to remove the white artifact, so the divider between the blue section and white invoice body matches the admin invoice design more closely.
- PDF attachments remain disabled by default unless EMAIL_ATTACH_DOCUMENT_PDF=1 is intentionally set in Cloudflare.


V213 PDF CLEANUP
- Removed the POS SOFTWARE FOR RETAIL heading from generated quote/invoice PDFs.
- Replaced the invoice/quote PDF logo with a transparent logo image so it sits directly on the blue sidebar without an extra logo background box.


============================================================
V215 REPORT ALIGNMENT UPDATE
============================================================
- Centered the HB Commerce logo, report title, period, and generated timestamp in Sales/P&L PDF exports.
- Centered the same header block in Excel/HTML exports using an Excel-friendly table header.
- Kept report exports free of graph images.
- Expanded the Sales Reports page chart to full available width so it starts and ends with the summary KPI row width.
- Kept the P&L Reports page two-chart layout unchanged on desktop.


Version v216: report PDF/Excel export header logo resized proportionally and centered; Sales/P&L report titles centered under the logo. No report data, graph, invoice PDF, or email-flow changes.


Version v218 update:
- Centers the Private Admin label under the HB logo in the admin sidebar/login presentation.
- Adds device classification for phone/tablet/desktop views.
- Adds final responsive layout overrides for admin portal, reports, document builder, public website pages, and online quote/invoice views.

v219 update:
- Made Approved Quotes, Open Invoices, and Paid Invoices admin sections responsive on phone/tablet by converting record tables into readable cards.
- Added stronger responsive public quote/invoice review styles for phone/tablet/desktop.
- Kept one-page PDF, invoice/quote design, paid status, report exports, and email button flow unchanged.


---

## v220 Apple Pay domain verification

This version serves the Apple Pay merchant-domain association file publicly at both routes below:

- /.well-known/apple-developer-merchantid-domain-association.txt
- /.well-known/apple-developer-merchantid-domain-association

The route is handled directly by the Cloudflare Worker and returns text/plain without requiring admin login. After deploying, open:

https://www.hbcommercesolution.com/.well-known/apple-developer-merchantid-domain-association.txt

Then return to Apple Developer / Authorize.Net Apple Pay setup and click Verify for the domain.


=== v222 Apple Pay Checkout Notes ===

This version adds Apple Pay as a checkout payment option in addition to Credit Card, Check, and Zelle. It also adds Apple Pay as an alternate option on the public invoice payment page when the customer is using an Apple Pay-capable browser/device.

Required Cloudflare/Apple settings before Apple Pay appears:

1. Keep the Apple domain-verification file live at:
   https://www.hbcommercesolution.com/.well-known/apple-developer-merchantid-domain-association.txt

2. APPLE_PAY_MERCHANT_ID is already set in wrangler.toml as:
   merchant.HBCOMMAUTH

   This identifier matches the Apple Pay certificates uploaded for this project. It is not a private secret.

3. Add optional variables if desired:
   APPLE_PAY_DISPLAY_NAME = HB Commerce Solutions
   APPLE_PAY_DOMAIN = www.hbcommercesolution.com
   APPLE_PAY_COUNTRY_CODE = US
   APPLE_PAY_CURRENCY_CODE = USD

4. Export the Apple Merchant Identity Certificate WITH its private key from the computer/keychain that created the CSR. Then upload the certificate and private key to Cloudflare mTLS and bind it as APPLE_PAY_MERCHANT_CERT in wrangler.toml:

   npx wrangler mtls-certificate upload --cert ./apple-merchant-identity.pem --key ./apple-merchant-identity.key --name hb-apple-pay-merchant-identity

   Then add the returned certificate_id to wrangler.toml:

   [[mtls_certificates]]
   binding = "APPLE_PAY_MERCHANT_CERT"
   certificate_id = "PASTE_CERTIFICATE_ID_HERE"

Do not commit certificate/key files to GitHub. Keep them outside the project folder.

Admin test page after deployment:
/admin/apple-pay-test

Apple Pay appears only on compatible Apple Pay devices/browsers with an active Wallet card. Other customers will continue seeing Credit Card, Check, and Zelle.


Important: the uploaded .cer file alone is not enough for Apple Pay web merchant validation. Cloudflare needs the Merchant Identity certificate plus the matching private key. Do not commit the certificate/key files to GitHub and do not send the private key in chat.
