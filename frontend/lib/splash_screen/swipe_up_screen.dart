import 'package:flutter/material.dart';
import 'package:frontend/home_page.dart'; // Import the new page here

class SwipeUpScreen extends StatefulWidget {
  @override
  _SwipeUpScreenState createState() => _SwipeUpScreenState();
}

class _SwipeUpScreenState extends State<SwipeUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _imageSizeAnimation;
  late Animation<double> _imageOffsetAnimation;
  late Animation<double> _welcomeOpacityAnimation;
  late Animation<Offset> _loginFormPositionAnimation;
  bool _showLoginForm = false;
  bool _isSignInButtonPressed = false;
  bool _isPhoneLogin = false;
  bool _showSignUpForm = false;
  bool _isSignUpPhone = false; // Track phone/email selection for sign up

  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _signUpPasswordController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });

    _imageSizeAnimation = Tween<double>(
      begin: 200.0,
      end: 80.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _imageOffsetAnimation = Tween<double>(
      begin: 0.0,
      end: -150.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _welcomeOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
    ));

    _loginFormPositionAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    _signUpPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSwipeUp() {
    if (!_controller.isAnimating) {
      _controller.forward().then((_) {
        setState(() {
          _showLoginForm = true;
        });
      });
    }
  }

  void _handleLogin() {
    final String emailOrPhone = _emailOrPhoneController.text;
    final String password = _passwordController.text;

    if (emailOrPhone.isNotEmpty && password.isNotEmpty) {
      // Navigate to HomePage after successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Show error or toast to inform user to enter all fields
      print('Please fill in both fields');
    }
  }

  void _handleSignUp() {
    final String emailOrPhone = _emailOrPhoneController.text;
    final String password = _signUpPasswordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (emailOrPhone.isNotEmpty &&
        password.isNotEmpty &&
        password == confirmPassword) {
      // Navigate to HomePage after successful sign up
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Show error or toast to inform user to enter all fields or passwords do not match
      print('Please fill in all fields correctly');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 192, 232, 172),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(
                      top: _imageOffsetAnimation.value
                          .clamp(0.0, double.infinity)),
                  child: SizedBox(
                    width: _imageSizeAnimation.value,
                    height: _imageSizeAnimation.value,
                    child: Image.asset(
                      'assets/cupcoffee.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.primaryDelta! < -10) {
                _handleSwipeUp();
              }
            },
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Swipe Up!',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.keyboard_double_arrow_up, size: 70),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: _imageOffsetAnimation.value + 80,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _welcomeOpacityAnimation,
              child: const Center(
                child: Text(
                  'Hello, welcome back!',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SlideTransition(
              position: _loginFormPositionAnimation,
              child:
                  _showLoginForm ? _buildLoginForm(context) : SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.62,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _showSignUpForm ? 'Sign Up' : 'Login',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _showSignUpForm ? _buildSignUpForm() : _buildLoginFields(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isSignInButtonPressed ? Colors.green : Colors.blue,
                minimumSize: const Size(double.infinity, 60),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                setState(() {
                  _isSignInButtonPressed = !_isSignInButtonPressed;
                });
                _showSignUpForm ? _handleSignUp() : _handleLogin();
              },
              child: Text(_showSignUpForm ? 'Sign Up' : 'Sign In'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                setState(() {
                  _showSignUpForm = !_showSignUpForm;
                });
              },
              child: Text(
                _showSignUpForm
                    ? 'Already have an account? Login'
                    : 'Don\'t have an account? Sign Up',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginFields() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.email,
                      color: !_isPhoneLogin ? Colors.blue : Colors.grey),
                  const SizedBox(width: 8),
                  const Text('Email'),
                ],
              ),
              selected: !_isPhoneLogin,
              onSelected: (selected) {
                setState(() {
                  _isPhoneLogin = !selected;
                });
              },
            ),
            const SizedBox(width: 16),
            ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone,
                      color: _isPhoneLogin ? Colors.blue : Colors.grey),
                  const SizedBox(width: 8),
                  const Text('Phone'),
                ],
              ),
              selected: _isPhoneLogin,
              onSelected: (selected) {
                setState(() {
                  _isPhoneLogin = selected;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _emailOrPhoneController,
          keyboardType:
              _isPhoneLogin ? TextInputType.phone : TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: _isPhoneLogin ? 'Phone Number' : 'Email Address',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.email,
                      color: !_isSignUpPhone ? Colors.blue : Colors.grey),
                  const SizedBox(width: 8),
                  const Text('Email'),
                ],
              ),
              selected: !_isSignUpPhone,
              onSelected: (selected) {
                setState(() {
                  _isSignUpPhone = !selected;
                });
              },
            ),
            const SizedBox(width: 16),
            ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone,
                      color: _isSignUpPhone ? Colors.blue : Colors.grey),
                  const SizedBox(width: 8),
                  const Text('Phone'),
                ],
              ),
              selected: _isSignUpPhone,
              onSelected: (selected) {
                setState(() {
                  _isSignUpPhone = selected;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _emailOrPhoneController,
          keyboardType:
              _isSignUpPhone ? TextInputType.phone : TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: _isSignUpPhone ? 'Phone Number' : 'Email Address',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _signUpPasswordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _confirmPasswordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Confirm Password',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
