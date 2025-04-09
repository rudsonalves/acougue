# acougue

A new Flutter project.

# ChangeLog

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
