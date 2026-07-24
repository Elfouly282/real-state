<p align="center">
  <table>
    <tr>
      <td width="25%"><img src="https://github.com/user-attachments/assets/eefa6c5a-5e9a-4a83-8281-6c5e071b14c2" alt="HabiSpace 1" /></td>
      <td width="25%"><img src="https://github.com/user-attachments/assets/32744972-ceed-430f-80d2-8615eed920f0" alt="HabiSpace 2" /></td>
      <td width="25%"><img src="https://github.com/user-attachments/assets/cbf949c6-642b-4ffa-9292-6b9c3d54b119" alt="HabiSpace 3" /></td>
      <td width="25%"><img src="https://github.com/user-attachments/assets/3d13e487-47ea-432f-8223-1b0fc12c4af3" alt="HabiSpace 4" /></td>
    </tr>
    <tr>
      <td width="25%"><img src="https://github.com/user-attachments/assets/6399e465-cffa-4f87-8144-292cc910240a" alt="HabiSpace 5" /></td>
      <td width="25%"><img src="https://github.com/user-attachments/assets/d49251f0-38d2-4ec5-ae0b-ab65724d710c" alt="HabiSpace 6" /></td>
      <td width="25%"><img src="https://github.com/user-attachments/assets/38a285d2-c22f-476a-8aa7-2b39b6bbe7e4" alt="HabiSpace 7" /></td>
      <td width="25%"><img src="https://github.com/user-attachments/assets/75c14e6a-5220-4d6d-8f20-517b2c441f90" alt="HabiSpace 8" /></td>
    </tr>
    <tr>
      <td width="25%"><img src="https://github.com/user-attachments/assets/7c444736-5353-45a9-8461-991ef7525014" alt="HabiSpace 9" /></td>
      <td width="25%"></td>
      <td width="25%"></td>
      <td width="25%"></td>
    </tr>
  </table>
</p>

A robust, multi-step checkout and payment system built for the HabiSpace Real Estate App. This module implements Clean Architecture, state management via BLoC/Cubit, secure WebView payment gateway integration (Stripe), and automated PDF receipt generation.

🌟 Key Features
🔄 5-Step Interactive Checkout Workflow:
Request to Book / Review Data: Property details, dates, add-ons, and insurance selection. Booking Details: Customer contact information and price itemization (property price + platform service fee). Payment Method Selection: Choose between Credit/Debit Cards, Digital Wallets, or alternative payment options. Secure Gateway Checkout: Embedded in-app WebView loading secure payment sessions (e.g., Stripe Checkout). Booking Confirmation & Receipt: Interactive success screen with instant PDF receipt generation and printing capabilities. 🏗️ Clean Architecture Pattern: Strict separation of concerns into Domain, Data, and Presentation layers. 🛡️ Secure API Communication: Authenticated HTTP requests powered by Dio with token handling. 📄 PDF Receipt Export: Generates printable PDF receipts using pdf and printing packages with exact transaction breakdowns. 📱 Responsive UI: Screen utility scaling across different device display sizes via flutter_screenutil. 📂 Architecture & Directory Structure
The feature follows Clean Architecture:

```text
lib/features/payment/
├── data/
│   ├── data_source/
│   │   ├── order_remote_data_source.dart
│   │   └── order_remote_data_source_imp.dart   # Dio POST request to /orders
│   ├── model/
│   │   └── order_payment_model.dart             # JSON serialization & mapping
│   └── repository/
│       └── order_repository_impl.dart           # Repository contract implementation
│
├── domain/
│   ├── entity/
│   │   ├── order_payment_entity.dart            # Core business entity
│   │   └── property_summary_entity.dart
│   ├── repository/
│   │   └── order_repository.dart                # Abstract interface
│   └── use_case/
│       └── create_order_use_case.dart           # Encapsulated business logic
│
└── presentation/
    ├── view/
    │   └── payment_view.dart                    # Main scaffold & step router
    ├── view_model/
    │   ├── payment_cubit.dart                   # BLoC Cubit managing checkout states
    │   └── payment_states.dart                  # Immutable state transitions
    └── widgets/
        ├── booking_app_bar.dart                 # Custom step title header
        ├── booking_bottom_bar.dart              # Action bar & step controls
        ├── payment_details_step.dart            # Form input & summary card
        ├── payment_method_selection_step.dart   # Gateway selector
        ├── payment_web_view_step.dart           # WebView payment container
        ├── payment_success_step.dart            # Success state & export UI
        └── receipt_pdf_service.dart             # Dynamic PDF generation service
