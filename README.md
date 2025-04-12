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

## 2025/04/12 - version: 0.50.02+18

### Add navigation drawer and FAB to enhance home page UX

This update introduces a navigation drawer and a floating action button (FAB) to the home page. It streamlines access to main features like product addition, employee management, and record viewing. It also includes refactoring of layout buttons and the relocation of the `CenterText` widget into its own reusable component.

### Modified Files

- **lib/ui/features/home/home_page.dart**
  - Added a `Drawer` with menu items for "Registros", "Adicionar Produto", and "Empregados".
  - Included a `FloatingActionButton.extended` to allow quick product additions.
  - Updated the top bar buttons from `FilledButton` to `ElevatedButton.icon` for improved accessibility and clarity.
  - Simplified layout by using the newly extracted `CenterText` widget across product listing rows.

### New Files

- **lib/ui/features/home/widgets/center_text.dart**
  - Introduced a new reusable widget `CenterText` that wraps centered text within an `Expanded` and applies consistent styling and overflow behavior.

### Conclusão

The interface is now more intuitive and easier to navigate, offering quicker access to key features with reusable UI components and a responsive layout.


## 2025/04/12 - version: 0.50.01+17

### Enable full user creation and editing with consistent ID handling

This commit finalizes user creation and editing flows by ensuring consistent handling of user IDs, especially when admins or managers create new users. It also adds tap-to-edit functionality in the employee list and improves the UI label for the sign-in form to better reflect expected input.

### Modified Files

- **lib/data/services/json_service.dart**
  - Changed `signUp` method to rethrow exceptions instead of returning `null`, allowing error handling to be centralized and standardized.

- **lib/ui/features/edit_user/edit_user_page.dart**
  - Ensured `createdAt` is properly set when a new user is created by someone else.
  - Adjusted ID assignment logic to correctly distinguish between current user updates and new user creation.

- **lib/ui/features/home/employees/employes_page.dart**
  - Added `onTap` support for each user in the list to open the edit form.
  - Linked each user to the edit screen via route arguments.

- **lib/ui/features/sign_in/sign_in.dart**
  - Renamed the "Nome" label to "Nome de Usuário" and updated the hint and icon to clarify the input expectations.

### Conclusão

With these updates, the system now fully supports the creation and editing of users by privileged roles, ensuring accurate user metadata and providing a smoother admin workflow.


## 2025/04/11 - version: 0.50.00+16

### Implement user management interface and employee listing

This commit introduces a complete user management interface, allowing admin and manager roles to view and register users. It includes enhancements to authentication logic, enriched user metadata (with roles), and UI integration for listing and editing users. Routes and view models were updated accordingly.

### Modified Files

- **lib/data/repositories/auth/auth_repository.dart**
  - Declared `getUser(String id)` method to retrieve a user by ID with access control.

- **lib/data/repositories/auth/local_auth_repository.dart**
  - Implemented role-based access control in `getUser`.
  - Replaced `log` with structured `Logger` for error handling.
  - Refactored and documented `_updateUserInfo`.
  - Updated `addUser`, `updateUser`, and `signOut` to refresh user info cache.

- **lib/data/repositories/products/products_repository.dart**
  - Minor formatting adjustments to imports.

- **lib/domain/dto/user_info.dart**
  - Extended `UserInfo` with the `position` field (enum `Positions`) to indicate user role.

- **lib/routing/router.dart**
  - Added new route: `/employees` for the employee list screen.
  - Updated `Routes.editUser` to support dynamic user editing via route arguments.

- **lib/ui/features/edit_user/edit_user_page.dart**
  - Refactored form to support both user creation and update.
  - Adjusted the button logic and labels accordingly.
  - Integrated `userId` argument to allow editing other users.
  - Improved user data prefill logic using the view model’s `getUser`.

- **lib/ui/features/edit_user/edit_view_model.dart**
  - Added `add` and `getUser` commands.
  - Enhanced logging with contextual tags.
  - Improved control flow in `_getUser` and `_getAddress`.

- **lib/ui/features/home/home_page.dart**
  - Replaced static "Cadastrar Pessoas" button with functional "Empregados" button linking to the employee list.
  - Hooked up route `/employees`.

- **lib/ui/features/splash/splash_page.dart**
  - Modified navigation after login to pass `userId` to `editUser` route.

- **lib/ui/features/splash/splash_view_model.dart**
  - Exposed `userId` for use during routing post-authentication.

### New Files

- **lib/ui/features/home/employees/employes_page.dart**
  - UI screen listing all users using `UserInfo` metadata.
  - Provides access to the user creation form.

- **lib/ui/features/home/employees/employees_view_model.dart**
  - View model to manage user metadata for the employee list screen.

### Conclusão

The user management functionality is now integrated and operational, supporting listing, editing, and registering users with proper role-based access control.


## 2025/04/11 - version: 0.20.02+15

### Enhance product lifecycle tracking and UI integration

This commit introduces the ability to retrieve user and freezer metadata, improves the `Product` repository logic, and significantly extends the UI and view models to support lifecycle tracking, including product expiration management. It adds expiration-based sorting, proper date handling, and richer display for administrative users.

### Modified Files

- **lib/data/repositories/auth/auth_repository.dart**
  - Added `listUserInfo` getter and `getUserInfo(String)` method to provide access to user metadata.

- **lib/data/repositories/auth/local_auth_repository.dart**
  - Implemented `listUserInfo` and `getUserInfo` using a local map.
  - Fetched and cached user info from the backend during initialization using `_mountUserInfo`.

- **lib/data/repositories/products/local_products_repository.dart**
  - Fixed a variable name bug when retrieving a product.
  - Ensured local cache is updated when deleting or updating a product.
  - Implemented `sortByExpirationDate`, which returns the product list sorted by expiration date (ascending or descending).

- **lib/data/repositories/products/products_repository.dart**
  - Declared `sortByExpirationDate` method in the abstract repository interface.

- **lib/routing/router.dart**
  - Updated `Routes.home` to instantiate `HomeViewModel` with required repositories.

- **lib/ui/features/home/edit_product/edit_product_page.dart**
  - Fixed incorrect method binding for expiration date picker.
  - Improved date picker initialization using state values.
  - Ensured date text fields are updated after loading a product.
  - Triggered a UI rebuild after product loading using `setState`.

- **lib/ui/features/home/edit_product/product_view_model.dart**
  - Reformatted imports for consistency.

- **lib/ui/features/home/home_page.dart**
  - Integrated `HomeViewModel` into the UI.
  - Displayed a list of products with status color coding based on expiration proximity.
  - Added user and freezer metadata to the UI.
  - Implemented reverse sorting by expiration date.
  - Navigated to the product editing screen on item tap.

- **lib/ui/features/home/home_view_model.dart**
  - Initialized repositories and provided accessors for products, freezers, and user info.
  - Implemented expiration date-based sorting with delegation to the repository.

### New Files

- **lib/domain/dto/user_info.dart**
  - Created `UserInfo` DTO to hold minimal user metadata for display purposes.

- **lib/ui/features/home/widgets/home_header_row.dart**
  - Added a reusable UI widget to render product list headers with interactive sorting on the "Validade" column.

### Conclusão

These changes significantly enhance product lifecycle visibility and management within the app, while introducing clean, modular components for UI rendering and data access.


## 2025/04/11 - version: 0.20.01+14

### Add product editing functionality with new models and UI integration

This commit introduces the product editing feature to the application. It includes updates to the domain model, new enums, a complete product form UI, and integration with routing and dependency injection. Minor UI and performance improvements were also made throughout the codebase.

### Modified Files

- **lib/config/dependencies.dart**
  - Added `LocalProductsRepository` to the list of provided dependencies.

- **lib/domain/enums/enums.dart**
  - Introduced `CutsType` enum to generalize cut classifications.
  - Updated `PrimalCuts` enum and moved it under the new structure.

- **lib/domain/models/product.dart**
  - Replaced `name` field with structured fields: `cutType`, `primalCut`, and `retailCuts`.
  - Added new fields: `comments`, `freezerId`, `employeeId`.
  - Updated `toMap`, `fromMap`, and `toString` methods accordingly.

- **lib/routing/router.dart**
  - Registered new route `editProduct`.
  - Implemented route logic to instantiate `EditProductPage` with appropriate `ProductViewModel`.

- **lib/ui/core/themes/dimens.dart**
  - Adjusted spacing and padding values for mobile and desktop layouts to improve visual alignment.

- **lib/ui/features/address/address_page.dart**
  - Renamed `_initializeAddress` to `_initialize` for consistency.
  - Fixed typo in the page title from "CriarEndereço" to "Criar Endereço".

- **lib/ui/features/address/address_view_model.dart**
  - Reduced artificial delay from 2 seconds to 1 second in `_save` and `_update`.
  - Improved error message clarity in `_getAddress`.

- **lib/ui/features/edit_user/edit_view_model.dart**
  - Reduced artificial delay in `_update` from 2 seconds to 1 second.

- **lib/ui/features/home/home_page.dart**
  - Refactored layout using `OverflowBar` instead of `SingleChildScrollView` for better button grouping.
  - Connected "Adicionar Produto" button to the new edit product route.

- **lib/ui/features/home/registrations/freezers/view_models/edit_freezer_view_model.dart**
  - Reduced artificial delay in save and update methods.

- **lib/ui/features/home/registrations/view_model/butcher_shop_view_model.dart**
  - Reduced artificial delay in `_update` method.

- **lib/ui/features/sign_in/sign_in_view_model.dart**
  - Reduced post-sign-in delay from 2 seconds to 1 second.

- **lib/ui/features/splash/splash_view_model.dart**
  - Reduced splash delay after initialization from 2 seconds to 1 second.

### New Files

- **lib/ui/features/home/edit_product/edit_product_page.dart**
  - Full implementation of a dynamic form for creating and editing products, supporting multiple cut types, freezer selection, and employee identification.

- **lib/ui/features/home/edit_product/product_view_model.dart**
  - ViewModel to manage product creation, edition, and retrieval logic. Interfaces with repositories and maintains the current user and freezer state.

### Conclusão

All new features were successfully implemented and integrated, enhancing the product management capabilities of the application.


## 2025/04/11 - version: 0.20.00+13

### Refactor to Use String Collections and Add Product Repository

This update completes the transition to using `String`-based identifiers for collections across all local repositories. It also introduces support for product data, including models, enums, repository interface and implementation. This foundation enables the application to manage meat cuts with detailed product metadata.

### Modified Files

- **lib/data/repositories/addresses/local_address_repository.dart**
  - Changed `addressCollection` to use `.name` string instead of enum.
  - Refactored all `JsonService` calls to use `String` identifiers.

- **lib/data/repositories/butcher_shop/local_butcher_shop_repository.dart**
  - Replaced enum-based `collection` usage with `.name`.
  - Standardized JSON interaction using string keys for consistency.

- **lib/data/repositories/common/collections.dart**
  - Added `products` to the `Collections` enum.

- **lib/data/repositories/freezers/local_freezers_repository.dart**
  - Updated `freezerCollection` to use string from enum name.
  - Applied consistent use of `String` collections in all service methods.

- **lib/data/services/json_service.dart**
  - Refactored `getAllFromCollection` to accept a `String` instead of enum.
  - Updated internal references from `collection.name` to `collection`.

- **lib/ui/features/home/registrations/registrations_page.dart**
  - Minor formatting and import path adjustments for clarity and consistency.

- **test/data/services/json_service_test.dart**
  - Updated `getAllFromCollection` test to use a string identifier.

### New Files

- **lib/data/repositories/products/local_products_repository.dart**
  - Implements the local product repository with methods to add, retrieve, update, and delete products.
  - Uses the `JsonService` for data persistence and retrieval.
  - Loads all product data on initialization.

- **lib/data/repositories/products/products_repository.dart**
  - Defines the `ProductsRepository` abstract class.
  - Declares methods for handling `Product` data and state.

- **lib/domain/enums/enums.dart**
  - Added enums for primal and retail meat cuts (e.g., `PrimalCuts`, `RetailCuts`, `Dianteiro`, etc.).
  - Each enum implements the `LabeledEnum` interface with readable labels.

- **lib/domain/models/product.dart**
  - Created the `Product` model class with fields for meat cut classification, weight, input and expiration dates.
  - Includes serialization (`toMap`) and deserialization (`fromMap`) logic.
  - Supports `copyWith` and `toString`.

### Conclusion

The system is now equipped to manage meat products and uses a consistent, simplified approach for collection identifiers throughout. This lays the groundwork for upcoming product-related features.


## 2025/04/11 - version: 0.10.05+12

### Refactor JsonService to Use String-Based Collection Identifiers

This update refactors the usage of the `JsonService` by replacing enum-based `Collections` parameters with simple `String` identifiers. This change standardizes collection access across the application and simplifies the service’s internal data structure. Affected repositories and routing logic were updated accordingly to align with this change.

### Modified Files

- **lib/data/repositories/addresses/local_address_repository.dart**
  - Replaced enum-based `collection` access with `.name` string values for all JSON operations (`insert`, `get`, `remove`, `update`).

- **lib/data/repositories/butcher_shop/local_butcher_shop_repository.dart**
  - Updated `deleteCollection`, `insertIntoCollection`, `removeFromCollection`, and `updateInCollection` to use `.name` strings instead of enum objects.

- **lib/data/repositories/freezers/local_freezers_repository.dart**
  - Applied `.name` for collection keys in all JSON service calls.
  - Fixed missing insertion into `_freezers` map after adding a new freezer.

- **lib/data/services/json_service.dart**
  - Updated all public methods to receive `String collection` instead of `Collections enum`.
  - Replaced internal usage of `collection.name` with direct string manipulation.
  - Adjusted error handling and key checks accordingly.

- **lib/routing/router.dart**
  - Refactored routing to support passing arguments (`freezerId`) to `EditFreezerPage`.
  - Moved freezer edit routing from static map to `onGenerateRoutes` for better argument handling.

- **lib/ui/features/home/registrations/freezers/freezers_page.dart**
  - Improved freezer listing with icons, description, and location.
  - Replaced add/edit navigation logic to support parameter passing using `freezerId`.

- **lib/ui/features/home/registrations/registrations_page.dart**
  - Enhanced the UI to display butcher and freezer data inside interactive cards.
  - Used `FreezersViewModel` to populate freezer information dynamically.
  - Adjusted layout and interaction flow for better clarity and responsiveness.

- **test/data/services/json_service_test.dart**
  - Updated unit tests to use string identifiers in all JSON service method calls (`insert`, `get`, `remove`, `update`).

### Conclusion

This refactor improves code clarity and consistency by removing enum-based logic in the JSON service. All affected modules are updated and tested, ensuring the system remains stable and functional.


## 2025/04/10 - version: 0.10.04+11

### Add Freezer Registration Feature with Edit and View Support

This update introduces full support for managing freezers and cold storage units, including their creation, edition, and listing. It also updates the domain model and repository logic to handle new data properties, improves validation and state handling, and integrates these components into the routing and registration flows.

### Modified Files

- **lib/config/dependencies.dart**
  - Registered `LocalFreezersRepository` in the dependency injection system.

- **lib/data/repositories/freezers/freezers_repository.dart**
  - Added `getFreezer(String id)` method.
  - Changed return type of `getAll()` to `Result<void>` to reflect void result pattern.

- **lib/data/repositories/freezers/local_freezers_repository.dart**
  - Migrated to use internal logger instead of `log()`.
  - Changed `getAll()` to load data into memory and return `Result<void>`.
  - Added `_initialize()` to preload freezer data on repository instantiation.
  - Added `getFreezer(id)` method to access cached data.

- **lib/domain/models/freezer.dart**
  - Added `maxVolume` and `maxPieces` fields to support storage limits.
  - Updated constructor, `copyWith`, `toMap`, and `fromMap` methods accordingly.
  - Enhanced `toString` for better debug output.

- **lib/routing/router.dart**
  - Added `Routes.freezers` and `Routes.editFreezer`.
  - Registered `FreezersPage` and `EditFreezerPage` in the routes map.

- **lib/ui/features/home/registrations/registrations_page.dart**
  - Linked “Registro dos Freezers” button to navigate to the `FreezersPage`.

### New Files

- **lib/ui/core/ui/customs_edit_controllers/numeric_edit_controller.dart**
  - Custom controller for numeric input fields with automatic validation, zero-stripping, and formatting.

- **lib/ui/core/ui/messages/center_message_page.dart**
  - Reusable widget to display a centered message with icon for empty states or alerts.

- **lib/ui/features/home/registrations/freezers/edit_freezer/edit_freezer_page.dart**
  - Full-featured form to create or edit freezer records, supporting both freezer and cold storage types.

- **lib/ui/features/home/registrations/freezers/freezers_page.dart**
  - Page listing all registered freezers with a floating action button to add a new one.

- **lib/ui/features/home/registrations/freezers/view_models/edit_freezer_view_model.dart**
  - ViewModel handling logic for saving and updating freezer data using repository methods and commands.

### Conclusion

The freezer registration module is now integrated into the system, with complete UI, validation, repository logic, and routing. All functionalities were tested and are working as expected.


## 2025/04/10 - version: 0.10.03+10

### Add Address Repository Initialization and Improve ButcherShop Display
  
This commit enhances the initialization of the `LocalAddressRepository` to automatically load existing addresses on startup. It also improves the modular organization by relocating `ButcherShopViewModel` to a dedicated `view_model` folder and enriches the `RegistrationsPage` with detailed Butcher Shop information, including address and formatted creation date.

### Modified Files

- **lib/data/repositories/addresses/address_repository.dart**
  - Added new abstract method `getAll()` to retrieve all address records.

- **lib/data/repositories/addresses/local_address_repository.dart**
  - Implemented `getAll()` to fetch all address data from the local JSON service.
  - Initialized address data on repository construction using `_initialize()`.

- **lib/domain/models/butcher_shop.dart**
  - Added a `toString()` method for easier debugging and logging.

- **lib/routing/router.dart**
  - Updated import paths to reflect relocation of `ButcherShopViewModel` into a `view_model` directory.
  - Passed `ButcherShopViewModel` instance to `RegistrationsPage`.

- **lib/ui/features/home/registrations/butcher_shop/butcher_shop_page.dart**
  - Updated import path for `ButcherShopViewModel`.

- **lib/ui/features/home/registrations/registrations_page.dart**
  - Changed to accept `ButcherShopViewModel` as a dependency.
  - Displayed Butcher Shop details using a styled `Card`, including address and formatted date.
  - Called `setState()` after returning from butcher registration to refresh data.

- **lib/ui/features/home/registrations/view_model/butcher_shop_view_model.dart**
  - Moved from previous location (`butcher_shop/`) to dedicated `view_model/` directory.
  - Added access to all loaded addresses via `addresses` getter.

### New File Paths

- **lib/ui/features/home/registrations/view_model/butcher_shop_view_model.dart**
  - Reorganized file previously located at `butcher_shop/butcher_shop_view_model.dart`.

### Deleted Files

- **lib/ui/features/home/registrations/registrations_view_model.dart**
  - Removed unused placeholder ViewModel file.

### Conclusion

This update improves data availability at runtime by initializing address data early and enhances the user interface with detailed, contextual information about the butcher shop. It also promotes clearer architecture by reorganizing ViewModel files.


## 2025/04/10 - version: 0.10.02+09

### Add Butcher Shop Registration and Centralize Dependency Management

This commit introduces the full flow for Butcher Shop registration and centralizes provider injection into a dedicated dependency configuration file. It also adds a logger utility to improve error tracking and replaces direct logging with structured log messages. Additional refactors include directory adjustments and model refinements to enhance maintainability.

### Modified Files

- **lib/config/dependencies.dart**
  - Added centralized list of providers (`dependencies()`) for core services and repositories.

- **lib/data/repositories/auth/auth_repository.dart**
  - Updated import path for `Credentials` from `models` to `dto`.

- **lib/data/repositories/auth/local_auth_repository.dart**
  - Adjusted import path to reflect `dto` relocation.

- **lib/data/repositories/butcher_shop/local_butcher_shop_repository.dart**
  - Triggered repository loading by calling `get()` in constructor.

- **lib/data/services/json_service.dart**
  - Introduced `Logger` for structured log output.
  - Split `_open()` into `_loadJsonFile()` and `_createJsonFile()`.
  - Added collection for `butcher_shop` and default record on creation.
  - Replaced `log()` with `logger.critical()` in all exception handlers.
  - Fixed collection insertion logic to append instead of overwrite.
  - Improved function signatures and ensured `getAllFromCollection()` returns empty list if missing.

- **lib/domain/models/credentials.dart** → **lib/domain/dto/credentials.dart**
  - File moved to better reflect separation of concerns between DTOs and Models.

- **lib/domain/models/address.dart**
  - Improved logic for formatting `fullAddress` to omit `complement` when empty.

- **lib/domain/models/butcher_shop.dart**
  - Made `addressId` nullable to support initial setup without address.
  - Updated mapping logic to handle `null` safely.

- **lib/main.dart**
  - Removed inline `MainApp` class.
  - Initialized `JsonService` and opened the local JSON database.
  - Used centralized `dependencies()` to inject services.

- **lib/routing/router.dart**
  - Registered new routes: `/registration` and `/butcher-shop`.
  - Injected dependencies in `ButcherShopViewModel`.

- **lib/ui/features/address/address_page.dart**
  - Fixed logic in `_onSaved()` and `_onUpdated()` to handle success and failure explicitly.
  - Ensured correct handling of new vs updated addresses by checking `_isUpdate`.

- **lib/ui/features/address/address_view_model.dart**
  - Fixed delayed state updates to use results from repository.
  - Improved logging clarity.

- **lib/ui/features/edit_user/edit_user_page.dart**
  - Adjusted logic to preserve existing `_addressId` if already defined.

- **lib/ui/features/edit_user/edit_view_model.dart**
  - Refactored constructor to named parameters for clarity and consistency.

- **lib/ui/features/home/home_page.dart**
  - Changed to `StatefulWidget`.
  - Added navigation to `RegistrationsPage`.

- **lib/ui/features/sign_in/sign_in.dart**
  - Updated import of `Credentials` to new `dto` location.

- **lib/ui/features/sign_in/sign_in_view_model.dart**
  - Updated import of `Credentials` to new `dto` location.

### New Files

- **lib/main_app.dart**
  - Extracted `MainApp` widget from `main.dart` for clarity.
  - Builds the root `MaterialApp` using `BrightnessController`.

- **lib/ui/features/home/registrations/butcher_shop/butcher_shop_page.dart**
  - Implements full UI form for editing Butcher Shop information.
  - Includes integration with address selector and date picker.

- **lib/ui/features/home/registrations/butcher_shop/butcher_shop_view_model.dart**
  - ViewModel to manage fetching and updating Butcher Shop data and address.

- **lib/ui/features/home/registrations/registrations_page.dart**
  - Landing page for different types of registrations (butcher, freezer, etc.).

- **lib/ui/features/home/registrations/registrations_view_model.dart**
  - Placeholder ViewModel for future expansion (currently empty).

- **lib/utils/extensions.dart**
  - Added `DateTime.toBrString()` for consistent Brazilian date formatting.

- **lib/utils/logger.dart**
  - Custom `Logger` class supporting color-coded terminal output and context tags.

### Conclusion

The butcher shop registration system is now fully integrated with a centralized architecture for dependency management, structured logging, and enhanced modularity.


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
