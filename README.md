# Açougue Sabor da Morte

## 1. Introdução

**Contexto:**  
O Sr. Jorge, proprietário de um conjunto de açougues, enfrenta multas decorrentes da comercialização de carnes com prazos de validade expirados. Em virtude disso, foi solicitado o desenvolvimento de uma solução offline que auxilie no controle dos prazos de validade dos estoques, evitando perdas e penalizações.

**Objetivo Geral:**  
Desenvolver um aplicativo offline para monitoramento e gerenciamento da validade dos produtos cárneos, permitindo o registro de cortes, acompanhamento dos prazos de vencimento e controle das movimentações do estoque.

---

## 2. Objetivos Específicos

- **Controle de Validade:**  
  Permitir o cadastro e monitoramento dos prazos de validade dos produtos, possibilitando notificações antecipadas, especialmente para produtos com vencimento inferior a uma semana.

- **Gestão de Estoques e Movimentações:**  
  Registrar as entradas e saídas dos produtos, com especial atenção às retiradas dos freezers, garantindo um controle rigoroso do estoque.

- **Emissão de Etiquetas:**  
  Gerar etiquetas para as embalagens com as informações essenciais (corte, validade, peso, data de vencimento e identificação do freezer de armazenamento).

- **Dashboard Administrativo:**  
  Disponibilizar um painel que consolide informações sobre estoques, descartes, próximos vencimentos e os funcionários responsáveis, facilitando a tomada de decisões.

---

## 3. Escopo do Projeto

- **Ambiente Offline:**  
  A aplicação deverá operar sem conexão com a internet, garantindo autonomia e confiabilidade, mesmo em ambientes com infraestrutura de rede limitada.

- **Múltiplos Açougues:**  
  O sistema deve suportar a gestão de diversos estabelecimentos, permitindo que cada açougue defina os próprios parâmetros para a duração dos produtos.

- **Usuários:**  
  O foco é em três perfis principais:  
  - **Administradores:** Responsáveis por monitorar o painel de controle, analisar os relatórios de estoque e acompanhar as notificações de vencimento.
  - **Gerentes:** Responsáveis pelas atividades em um estabelecimento, como o cadastro de pessoal, gerenciamento do sistema e controle de acessos.
  - **Funcionários:** Responsáveis pelo registro dos cortes, lançamentos de movimentações e emissão de etiquetas.  

---

## 4. Requisitos Funcionais

1. **Cadastro de Produtos:**
   - **Informações Necessárias:**  
     - *Corte:* Tipo de corte da carne.
     - *Validades:* Definição de prazos específicos para cada tipo de carne, conforme a política de cada açougue.
     - *Peso:* Quantidade registrada.
     - *Data de Vencimento:* Prazo de validade individual.
     - *Identificação do Freezer:* Local de armazenamento.
   - **Geração de Etiquetas:**  
     - Após o cadastro, o sistema deverá gerar automaticamente uma etiqueta para a embalagem, contendo todas as informações relevantes.

2. **Notificações e Alertas:**
   - Exibir anúncios dos produtos cujo vencimento esteja próximo, com destaque para aqueles com menos de uma semana para expiração.
   - Notificar os responsáveis para que possam tomar medidas preventivas (como priorizar o consumo ou redirecionar a comercialização).

3. **Registro de Movimentações:**
   - Lançamento das saídas dos estoques e dos freezers, possibilitando a rastreabilidade de cada produto retirado.

4. **Painel Administrativo:**
   - Consolidação de informações em tempo real (dentro do ambiente offline) sobre:
     - Níveis de estoque.
     - Produtos descartados.
     - Próximos vencimentos.
     - Responsáveis pelas operações.

---

## 5. Requisitos Não Funcionais

- **Operacionalidade Offline:**  
  O sistema deverá ser capaz de funcionar de forma autônoma, sem dependência de conexão à internet, garantindo alta disponibilidade.

- **Usabilidade e Interface:**  
  Interface intuitiva e de fácil navegação, considerando que os usuários (funcionários e administradores) podem não ter elevado grau de familiaridade com tecnologias.

- **Segurança:**  
  Implementação de mecanismos para assegurar a integridade e confidencialidade dos dados, mesmo em ambiente local.

- **Escalabilidade:**  
  Capacidade de gerenciar múltiplos açougues com possíveis variações nos parâmetros de validade e processos internos.

- **Confiabilidade:**  
  Garantia de que os registros e notificações são precisos e atualizados, minimizando erros que possam resultar em perdas ou multas.

---

## 6. Considerações Técnicas e Opiniões

- **Abordagem Offline:**  
  A escolha por uma solução offline é pertinente, pois reduz riscos associados a instabilidades de conexão e garante operação contínua. Contudo, é crucial planejar uma estratégia de backup e, se possível, uma sincronização eventual para preservar os dados em caso de falhas do sistema.

- **Customização por Unidade:**  
  Permitir que cada açougue defina a duração dos produtos é uma decisão acertada, visto que diferentes estabelecimentos podem ter políticas e condições de armazenamento diversas. Essa flexibilidade deve ser refletida tanto no cadastro quanto na geração de alertas.

- **Interface e Usabilidade:**  
  A clareza na interface, especialmente para a emissão de etiquetas e lançamentos de movimentações, é fundamental. Recomenda-se a realização de testes com usuários finais para garantir que o fluxo seja intuitivo e que as notificações sejam destacadas de forma eficaz.

- **Dashboard Administrativo:**  
  A centralização das informações em um painel facilita a gestão estratégica e operacional. Recomenda-se a inclusão de gráficos e relatórios que auxiliem na visualização dos dados, mesmo que o sistema seja offline.

- **Processos de Cadastro e Movimentação:**  
  A integração entre o cadastro dos produtos e o registro das movimentações é essencial para manter a rastreabilidade e evitar discrepâncias nos estoques. É recomendável que o sistema possua validações rigorosas para evitar a entrada de dados incorretos.

---

## 7. Fluxo do Processo

1. **Cadastro Inicial:**
   - Funcionário registra o corte da carne com as informações necessárias.
   - O sistema gera automaticamente uma etiqueta para a embalagem.

2. **Monitoramento:**
   - O aplicativo verifica os prazos de validade cadastrados.
   - Produtos com vencimento em menos de uma semana são destacados na interface.

3. **Registro de Saídas:**
   - Cada retirada de produto do estoque ou freezer é lançada no sistema.
   - O histórico de movimentações é atualizado para fins de auditoria e controle.

4. **Análise Administrativa:**
   - Administradores acessam o painel para revisar estoques, descartes e próximos vencimentos.
   - Relatórios e notificações auxiliam na tomada de decisão para evitar prejuízos e multas.

---

## 8. Conclusão

A proposta apresentada busca oferecer uma solução robusta e customizável para o controle de prazos de validade em açougues, garantindo que as operações ocorram de forma segura e eficiente mesmo em ambientes offline. A ênfase na facilidade de uso, combinada com um sistema rigoroso de notificações e registros, contribuirá significativamente para a redução de perdas e a melhoria do gerenciamento de estoques. Em suma, o projeto não só atenderá às necessidades do Sr. Jorge, mas também poderá servir de modelo para outros estabelecimentos que enfrentem desafios similares.

---

Esta estrutura serve como ponto de partida para o desenvolvimento detalhado do projeto, permitindo que as etapas seguintes (como a definição da arquitetura técnica, escolha de tecnologias e planejamento de testes) sejam realizadas de maneira organizada e fundamentada.



# ChangeLog

## 2025/04/10 - version: 0.10.01+08

### Add freezer management feature and offline support improvements

This commit introduces the foundational structure for managing freezers in the butcher shop application. It includes the creation of a `Freezer` model, associated repository interfaces, and local storage integration. Enhancements were also made to existing repositories and services to support modular and consistent offline operations. The README was significantly expanded to provide a clear, documented vision of the application scope and requirements.

### Modified Files

- **README.md**
  - Replaced placeholder content with a detailed technical and functional description of the project's context, objectives, and structure.

- **lib/data/repositories/addresses/address_repository.dart**
  - Minor formatting adjustment for code clarity.

- **lib/data/repositories/addresses/local_address_repository.dart**
  - Renamed internal variable from `_database` to `_jsonServer` for better clarity and consistency with other repositories.

- **lib/data/repositories/auth/local_auth_repository.dart**
  - Replaced `_database` with `_jsonServer` to standardize terminology across repositories.

- **lib/data/repositories/butcher_shop/local_butcher_shop_repository.dart**
  - Updated internal database reference naming for consistency.
  - Formatted some calls across multiple lines for improved readability.

- **lib/data/repositories/common/collections.dart**
  - Added `freezers` to the `Collections` enum.

- **lib/data/services/json_service.dart**
  - Modified `removeFromCollection` and `updateInCollection` to return `void` and rethrow exceptions.
  - Added constant `_idLength` to replace magic number in UID generation.

- **lib/domain/enums/enums.dart**
  - Added two new enums: `VolumetricUnit` and `FreezerType`, used for freezer representation.

- **lib/domain/models/butcher_shop.dart**
  - Removed `toJson`, `fromJson`, and `toString` methods to simplify the model.

- **lib/domain/models/user.dart**
  - Removed JSON serialization and `toString` methods, matching recent design decisions.

- **lib/routing/router.dart**
  - Injected `HomeViewModel` into `HomePage`.
  - Removed `SignUpPage` and related imports, reflecting the removal of the sign-up feature.

- **lib/ui/features/address/address_page.dart**
  - Added support for address update flow (distinguishing between new and existing addresses).
  - Modified form title, button label, and icon dynamically based on whether the page is in "edit" mode.
  - Handled save/update execution and result callbacks accordingly.

- **lib/ui/features/edit_user/edit_user_page.dart**
  - Fixed bug by assigning `_addressId` to the `User` model during update.

- **lib/ui/features/home/home_page.dart**
  - Changed constructor to require `HomeViewModel`.
  - Replaced login navigation with multiple buttons for freezer, product, employee, and validity registration.

### New Files

- **lib/data/repositories/freezers/freezers_repository.dart**
  - Defines the abstract contract for freezer-related operations.

- **lib/data/repositories/freezers/local_freezers_repository.dart**
  - Implements freezer operations using the local JSON service.

- **lib/domain/models/freezer.dart**
  - Contains the `Freezer` model with fields, serialization methods, and a descriptive `toString`.

- **lib/ui/features/home/home_view_model.dart**
  - Basic `HomeViewModel` to support future state management for the home screen.

- **test/data/repositories/freezers/local_freezers_repository_test.dart**
  - Unit tests to verify CRUD functionality for the local freezer repository.

### Deleted Files

- **lib/ui/features/sign_up/sign_up_page.dart**
- **lib/ui/features/sign_up/sign_up_view_model.dart**
  - Removed sign-up functionality, possibly in favor of predefined users or admin-only account management.

### Assets and Test Data

- No assets or static test data added.

### Conclusion

The freezer module was successfully introduced along with supporting infrastructure for modular, local storage operations. The project documentation is now comprehensive, and the codebase is consistent with clean and scalable design principles.


## 2025/04/09 - version: 0.10.00+07

### Enhance Address and User Form Usability with Layout and Behavior Updates

This commit improves form input usability and layout consistency across the address and user editing interfaces. It includes enhancements for responsive design, form interaction constraints (like `readOnly` fields), and layout alignment for better UX across screen sizes.

### Modified Files

- **lib/ui/core/themes/dimens.dart**
  - Adjusted `desktop` layout values:
    - Changed `paddingScreenAll` from shared `Dimens.paddingAll` to fixed `15.0`.
    - Reduced `paddingScreenHorizontal` from `100.0` to `25.0` for better usability on wider screens.

- **lib/ui/core/ui/text_fields/basic_text_field.dart**
  - Added a `readOnly` parameter to allow non-editable text fields.
  - Passed the `readOnly` flag to the `TextFormField` widget.

- **lib/ui/features/address/address_page.dart**
  - Triggered a `setState()` call after address initialization to ensure form fields are updated visually when loading existing address data.

- **lib/ui/features/edit_user/edit_user_page.dart**
  - Marked the address field as `readOnly` to prevent manual editing; navigation to a specific form page is now required for updates.
  - Refactored the layout for "Contato" and "Documento" fields into a horizontal row using `Expanded`, enhancing UI consistency and readability.
  - Called `setState()` after loading and populating the address data to ensure immediate UI refresh.

### Conclusão

These adjustments significantly improve form behavior, visual consistency, and user interaction flow, particularly on desktop screens or wider mobile devices. The changes ensure data is correctly displayed and edited only through designated workflows.


## 2025/04/09 - version: 0.01.02+06

### Add Support for Address Editing and Callback Integration
 
This commit introduces support for editing existing addresses, including a callback mechanism to return address data to the previous screen. It also integrates full address display, dynamic navigation routing with arguments, and view model enhancements to retrieve address data by ID.

### Modified Files
- **.gitignore**
  - Ignored the `/storage/` directory to prevent local test data from being committed.

- **lib/domain/models/address.dart**
  - Added a `fullAddress` getter to format address fields into a readable string.

- **lib/main.dart**
  - Switched from static route mapping to `onGenerateRoute` for dynamic navigation with arguments.

- **lib/routing/router.dart**
  - Refactored to use `onGenerateRoutes`.
  - Address page now accepts and handles `addressId` and a `callBack` function via `RouteSettings.arguments`.

- **lib/ui/features/address/address_page.dart**
  - Added `callBack` and `addressId` parameters.
  - Implemented `_initializeAddress()` to pre-fill form fields for editing.
  - Updated `_onSaved()` to invoke the callback with the saved address object.

- **lib/ui/features/address/address_view_model.dart**
  - Added `_getAddress()` method and related `Command1` to retrieve address by ID.
  - Updated state to store and expose the current address instance.

- **lib/ui/features/edit_user/edit_user_page.dart**
  - Updated to store and manage `addressId`.
  - Calls the address page with current `addressId` and a callback.
  - Receives the updated address and updates the UI accordingly.

- **lib/ui/features/edit_user/edit_view_model.dart**
  - Added `getAddress()` method to fetch address data.
  - Stores and exposes the current address instance for UI consumption.

### Deleted Files
- **storage/data.json**
  - Removed old mock data as persistent storage is now ignored via `.gitignore`.

### Conclusion
The app now supports full address editing and integrates a structured callback system to return data between views, enhancing the modularity and user flow for address management.


## 2025/04/09 - version: 0.01.01+05

### Add Address Management UI and Improve Validation Rules

This commit introduces a complete interface for managing user addresses, including a new address form page, view model, and enumeration for Brazilian states. It also enhances code consistency by enforcing constant constructors and literals, and improves form validation logic throughout the app.

### Modified Files
- **analysis_options.yaml**
  - Enforced `prefer_const_constructors` and `prefer_const_literals_to_create_immutables` lint rules.

- **lib/data/repositories/addresses/address_repository.dart**
  - Updated imports to use relative paths.

- **lib/data/repositories/addresses/local_address_repository.dart**
  - Marked success responses with `const` constructors for optimization.

- **lib/data/repositories/auth/local_auth_repository.dart**
  - Enforced `const` usage in success results.
  - Added null-checking for login credentials to handle failed authentication gracefully.

- **lib/data/repositories/butcher_shop/local_butcher_shop_repository.dart**
  - Marked `Result.success` with `const`.

- **lib/data/services/json_service.dart**
  - Improved validation logic to compare user IDs instead of names.

- **lib/domain/enums/enums.dart**
  - Added `BrStates` enum with full list of Brazilian states and labels.
  - Included `ignore_for_file` comment for constant naming convention.

- **lib/main.dart**
  - Registered `LocalAddressRepository` in provider list.
  - Used `const` constructor for `MaterialTheme`.

- **lib/routing/router.dart**
  - Registered new route `/address` and injected `AddressViewModel`.

- **lib/ui/core/themes/fonts.dart**
  - Added `const` to all `TextStyle` constructors for optimization.

- **lib/ui/core/ui/buttons/big_button.dart**
  - Used `const` constructors in `CircularProgressIndicator` and `SizedBox`.

- **lib/ui/core/ui/buttons/text_row_button.dart**
  - Used `const` in `TextStyle`.

- **lib/ui/core/ui/messages/app_snack_bar.dart**
  - Used `const Divider`.

- **lib/ui/core/ui/text_fields/basic_dropdown_fielt.dart**
  - Added support for `hintText` and `floatingLabelBehavior`.

- **lib/ui/features/edit_user/edit_user_page.dart**
  - Enhanced layout and styling.
  - Added logic to navigate to the address form.
  - Implemented `ListenableBuilder` to show loading state on update button.
  - Refactored update logic to show error message via `AppSnackBar`.

- **lib/ui/features/edit_user/edit_view_model.dart**
  - Introduced artificial delay in `update` for better UX feedback.

- **lib/ui/features/sign_in/sign_in.dart**
  - Commented out account creation navigation.
  - Replaced navigation on login success with simple `Navigator.pop`.
  - Adjusted error handling message.

- **lib/ui/features/sign_in/sign_in_view_model.dart**
  - Wrapped error in `Result.failure` instead of rethrowing.

- **lib/ui/features/sign_up/sign_up_page.dart**
  - Converted title `Text` widget to `const`.

- **lib/ui/features/splash/splash_page.dart**
  - Used `const` in `AnimatedScale` child and duration.

- **lib/ui/features/splash/splash_view_model.dart**
  - Made delay `Duration` constant.

- **lib/utils/validate.dart**
  - Added `docNumber` and `simple` validation methods.
  - Introduced a shared RegExp pattern for document number format.

- **storage/data.json**
  - Added an initial address object and updated the user object with new ID.

### New Files
- **lib/ui/features/address/address_page.dart**
  - Complete address form UI for adding user address data.
  - Includes input fields, dropdowns for address type and state, and submission logic.

- **lib/ui/features/address/address_view_model.dart**
  - ViewModel handling address save and update logic via Command pattern.

### Conclusion
All features and refactors were successfully integrated, enhancing the app's user profile management capabilities and improving code quality across the board.


## 2025/04/09 - version: 0.01.00+04

### Add user editing functionality and refactor related structure

This update introduces the ability for users to edit their profile data. A new `EditUserPage` and corresponding `EditViewModel` were created to manage the user update flow. Additionally, the `AuthRepository` was extended to support the update operation. Minor improvements and refactorings were also made throughout the app, including asset relocation and validation logic centralization.

### Modified Files

- **lib/data/repositories/auth/auth_repository.dart**
  - Added new abstract method `updateUser(User user)` to support user profile updates.

- **lib/data/repositories/auth/local_auth_repository.dart**
  - Implemented the `updateUser` method using `_database.updateUser`.
  - Updated internal user logic to reflect the most recent state upon update.

- **lib/domain/models/user.dart**
  - Made `addressId` nullable to allow optional address assignment.
  - Updated the `fromMap` method accordingly.

- **lib/main.dart**
  - Changed JSON data path from `'data.json'` to `'storage/data.json'`.

- **lib/routing/router.dart**
  - Registered a new route `editUser` and wired it to `EditUserPage` and `EditViewModel`.

- **lib/ui/core/ui/text_fields/basic_text_field.dart**
  - Added `hintStyle` with semi-transparent secondary color for better visual consistency.

- **lib/ui/features/sign_in/sign_in.dart**
  - Adjusted import path for `logo_image.dart` due to file relocation.

- **lib/ui/features/sign_up/sign_up_view_model.dart**
  - Changed the sign-up logic to directly use `User` instead of `Credentials`.
  - Removed the unused `Credentials` import.

- **lib/ui/features/splash/splash_page.dart**
  - Modified navigation to redirect to `EditUserPage` upon successful auto-login.

- **lib/utils/validate.dart**
  - Added a `generic` validator method to check for empty fields and minimum length.

- **pubspec.yaml**
  - Registered `storage/` as an assets path to accommodate the new data location.

### New Files

- **lib/ui/features/edit_user/edit_user_page.dart**
  - Implements a complete UI form for editing user information, including validation and layout logic.

- **lib/ui/features/edit_user/edit_view_model.dart**
  - Handles the business logic for user update requests, including calling the repository and managing results.

- **lib/ui/core/ui/text_fields/basic_dropdown_fielt.dart**
  - A reusable dropdown form field widget for use in user forms or other feature UIs.

### Renamed Files

- **lib/ui/core/ui/logo_image.dart** → **lib/ui/core/ui/images/logo_image.dart**
  - File moved to a more appropriate directory for image-related components.

- **data.json** → **storage/data.json**
  - Relocated data file to the `storage/` folder for better separation of concerns.

### Assets and Test Data

- **assets/images/svg/logo.svg**
  - Added a new SVG logo asset for use in UI components.

### Conclusion

The user profile editing flow is now fully integrated and functional, alongside related improvements and refactorings to the codebase.


## 2025/04/08 - version: 0.01.00+03

This commit introduces the complete local authentication flow using a JSON-based service and implements a splash screen for auto-login logic.

### Modified Files

- **`pubspec.yaml`**
  - Added assets path for `assets/images/`.

- **`lib/data/repositories/auth/auth_repository.dart`**
  - Introduced `initialize()` method for auto-login and updated `signIn()` to use `Credentials`.

- **`lib/data/repositories/auth/local_auth_repository.dart`**
  - Implemented `initialize()` logic for splash screen auto-login.
  - Modified `signIn()` to accept a `Credentials` object.
  - Updated password change logic to only allow logged-in users to update their own passwords.

- **`lib/data/services/json_service.dart`**
  - Added `usersMap` getter for listing users from the raw JSON.
  - Documented and updated `removeUser()` and `updateUser()` methods with detailed validation and logging.

- **`lib/main.dart`**
  - Registered `LocalAuthRepository` as a provider using the same `JsonService` instance.

- **`lib/routing/router.dart`**
  - Changed `initialRoute` to `splash`.
  - Injected `SignInViewModel`, `SignUpViewModel`, and `SplashViewModel` into respective pages.

- **`lib/ui/core/themes/brightness_controller.dart`**
  - Changed default theme brightness from light to dark.

- **`lib/utils/commands.dart`**
  - Removed `notifyListeners()` call in `clearResult()` to prevent unnecessary rebuilds.

### New Files

- **`lib/domain/models/credentials.dart`**
  - Model to encapsulate name and password for sign-in/sign-up.

- **`lib/ui/features/sign_in/sign_in.dart`**
  - Redesigned login screen with validation, reactivity, and navigation.
  - Uses `Command1` pattern for clean state management.

- **`lib/ui/features/sign_in/sign_in_view_model.dart`**
  - Implements sign-in logic using `AuthRepository`.

- **`lib/ui/features/sign_up/sign_up_page.dart`**
  - Redesigned sign-up screen with validations and success/error feedback.

- **`lib/ui/features/sign_up/sign_up_view_model.dart`**
  - Implements user registration flow logic (currently mocked as success).

- **`lib/ui/features/splash/splash_page.dart`**
  - Displays a logo animation and checks auto-login using the repository.

- **`lib/ui/features/splash/splash_view_model.dart`**
  - Executes the login check during splash screen initialization.

- **`lib/ui/core/ui/logo_image.dart`**
  - Displays the circular logo from `assets/images/logo.png`.

- **`lib/ui/core/ui/messages/app_snack_bar.dart`**
  - Utility for displaying custom `SnackBar` messages with optional icons and actions.

- **`lib/ui/core/ui/buttons/big_button.dart`**
  - Styled button with optional icon and loading state.

- **`lib/ui/core/ui/buttons/text_row_button.dart`**
  - Displays inline text + button for navigation or secondary actions.

- **`lib/ui/core/ui/text_fields/basic_text_field.dart`**
  - Custom `TextFormField` with reusability and styling options.

- **`lib/ui/core/ui/text_fields/secret_text_field.dart`**
  - Extends `BasicTextField` to hide/show password field.

- **`lib/ui/core/themes/dimens.dart`**
  - Defines spacing and layout constants for responsive design.

- **`lib/ui/core/themes/fonts.dart`**
  - Defines font sizes and family configurations for mobile and desktop.

### Assets and Test Data

- **`assets/images/logo.png`**
  - Added logo used in splash and authentication screens.

- **`data.json`**
  - Includes default admin user for initial tests.

With these changes, the app now supports a fully functional local authentication flow including auto-login, sign-up, and password update, while offering a polished UI with validation and feedback.


## 2025/04/08 - version: 0.01.00+02

This commit introduces significant enhancements to the user authentication and local database management logic. It includes the implementation of a new local authentication repository, refactors user-related operations, improves serialization formats, adds validations, and introduces comprehensive test coverage.

### Changes made:

1. **lib/data/repositories/auth/auth_repository.dart**:
   - Added a `user` getter to expose the currently signed-in user.
   - Replaced the `signUp` method with a more flexible `addUser` method that accepts a `User` object.

2. **lib/data/repositories/auth/local_auth_repository.dart**:
   - Created a new implementation `LocalAuthRepository` for local user authentication using `JsonDatabaseService`.
   - Implemented `signIn`, `signOut`, `changePassword`, and `addUser` methods with internal user state handling and error management.

3. **lib/data/services/json_database_service.dart**:
   - Enhanced `open()` method with safe initialization and admin user fallback creation.
   - Replaced `signIn` return type to return `User?` instead of throwing on error.
   - Replaced `_findUser` with `_findUserByName` to improve clarity.
   - Updated `addUser` method with robust validation for permissions, duplication, and role-based constraints.
   - Implemented `removeUser` and `updateUser` methods for local user account management with permission checks.
   - Improved collection methods (`insertIntoCollection`, `removeFromCollection`, `updateInCollection`) to return `bool` or `String?` instead of throwing, with improved error handling and logging.
   - Adjusted internal user serialization to use `millisecondsSinceEpoch` for `createdAt` and `updatedAt`.

4. **lib/domain/models/butcher_shop.dart**:
   - Refactored `toMap` and `fromMap` methods to serialize/deserialize `createdAt` and `updatedAt` using `millisecondsSinceEpoch` for consistency and compatibility with JSON.

5. **lib/domain/models/user.dart**:
   - Made `createdAt` optional in constructor with default value as `DateTime.now()`.
   - Updated `toMap` and `fromMap` methods to use `millisecondsSinceEpoch` for timestamp fields to standardize JSON compatibility.

6. **lib/utils/validate.dart**:
   - Added detailed documentation for all validation methods.
   - Introduced validation logic for `password` and `confirmPassword` with error message returns.

7. **test/data/services/json_database_service_test.dart**:
   - Added a comprehensive suite of tests for `JsonDatabaseService` covering:
     - Open and close behavior
     - Admin sign in/out logic
     - Add, update, and remove users under different permission levels (admin, manager, employee)
     - Full CRUD testing of collection-based operations

8. **test/widget_test.dart**:
   - Deleted default widget test as it is no longer relevant to current application logic.

9. **coverage/lcov.info**:
   - Added code coverage report file generated by test runs.

### Conclusion:

These changes establish a robust foundation for user account management with proper validation, permissions, and comprehensive testing. The new local authentication system enhances modularity and testability, paving the way for scalable authentication workflows.


## 2025/04/08 - version: 0.01.00+01
    
Added user authentication features, refactored JSON database service, and improved repository interfaces.
    
### Changes made:
    
1. **Makefile**:
   - Added targets for common git operations (`diff`, `push`, `push_branch`), Flutter rebuild, and test coverage.
    
2. **lib/data/repositories/addresses/address_repository.dart**:
   - Added `addresses` and `addressList` getters to provide local access to address data.
    
3. **lib/data/repositories/addresses/local_address_repository.dart**:
   - Replaced `AppConstants` with `Collections` enum for better consistency.
   - Refactored to use `addressCollection` constant.
   - Implemented the new `addresses` and `addressList` getters.
    
4. **lib/data/repositories/auth/auth_repository.dart**:
   - Created new abstract `AuthRepository` with methods for sign-in, sign-up, sign-out, and password change.
  
5. **lib/data/repositories/butcher_shop/butcher_shop_repository.dart**:
   - Added `butcher` getter for accessing local butcher shop data.
    
6. **lib/data/repositories/butcher_shop/local_butcher_shop_repository.dart**:
   - Replaced `AppConstants` with `Collections` enum.
   - Added `butcherCollection` constant.
   - Refactored CRUD operations to use the enum-based collection name.
    
7. **lib/data/repositories/common/app_constats.dart**:
   - Deleted legacy file with hardcoded collection constants.
    
8. **lib/data/repositories/common/collections.dart**:
   - Created `Collections` enum to centralize and type-safe collection names.
    
9. **lib/data/services/json_database_service.dart**:
   - Refactored all methods to use the `Collections` enum.
   - Added `loggedUser` getter with masked password.
   - Implemented `signIn`, `signOut`, and `signUp` user authentication methods.
   - Added internal `_findUser` method to locate users by name.
   - Added user auto-creation on database initialization (admin).
   - Increased UID generation size from 12 to 32 characters.
    
10. **lib/domain/enums/enums.dart**:
    - Added `Positions` enum with labels to define user roles.
    
11. **lib/domain/models/user.dart**:
    - Created `User` model with serialization, deserialization, and utility methods.
    
12. **lib/main.dart**:
    - Refactored imports to a cleaner format.
    - Updated JSON database import path to `json_database_service.dart`.
    
### Conclusion:
    
This commit introduces a foundational user authentication system, transitioning to a more structured approach using enums for collections and user roles. It also enhances repository interfaces and brings consistency across the database service through refactoring and better design principles.
