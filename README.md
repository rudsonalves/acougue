# acougue

A new Flutter project.

# ChangeLog

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
