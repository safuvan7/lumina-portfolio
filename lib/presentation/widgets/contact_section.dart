import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lumina/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'mohdsafu26@gmail.com',
      queryParameters: {
        'subject': _subjectController.text.trim().isEmpty
            ? 'Portfolio Contact'
            : _subjectController.text.trim(),
        'body':
            '''
Name: ${_nameController.text.trim()}
Email: ${_emailController.text.trim()}

${_messageController.text.trim()}
''',
      },
    );

    try {
      final launched = await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        _showMessage('Unable to open your email application.');
      }
    } catch (e) {
      if (mounted) {
        _showMessage('Something went wrong. Please try again.');
      }
    }
  }

  Future<void> _openPhone() async {
    final Uri uri = Uri(scheme: 'tel', path: '+971545706295');

    await launchUrl(uri);
  }

  Future<void> _openEmail() async {
    final Uri uri = Uri(scheme: 'mailto', path: 'mohdsafu26@gmail.com');

    await launchUrl(uri);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final isMobile = width < 700;
    final titleSize = isMobile ? 34.0 : 44.0;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 30,
        vertical: isMobile ? 70 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              //   ================= HEADER ==================== //
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Get In ',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: 'Touch',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 18),

              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 650),
                child: Text(
                  'Ready to start a project? Send me a message.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 17,
                    height: 1.6,
                  ),
                ),
              ),

              SizedBox(height: 65),

              // ============================================================
              // CONTACT GLASS CARD
              // ============================================================
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isMobile ? 24 : 42),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.055),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: AppColors.surfaceBorder),
                    ),
                    child: isMobile
                        ? Column(
                            children: [
                              _ContactInformation(
                                onPhoneTap: _openPhone,
                                onEmailTap: _openEmail,
                              ),
                              SizedBox(height: 45),
                              _ContactForm(
                                formKey: _formKey,
                                nameController: _nameController,
                                emailController: _emailController,
                                subjectController: _subjectController,
                                messageController: _messageController,
                                onSendMessage: _sendMessage,
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: _ContactInformation(
                                  onPhoneTap: _openPhone,
                                  onEmailTap: _openEmail,
                                ),
                              ),
                              SizedBox(width: 50),

                              Expanded(
                                flex: 6,
                                child: _ContactForm(
                                  formKey: _formKey,
                                  nameController: _nameController,
                                  emailController: _emailController,
                                  subjectController: _subjectController,
                                  messageController: _messageController,
                                  onSendMessage: _sendMessage,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CONTACT INFORMATION
// ============================================================

class _ContactInformation extends StatelessWidget {
  const _ContactInformation({
    required this.onPhoneTap,
    required this.onEmailTap,
  });

  final VoidCallback onPhoneTap;
  final VoidCallback onEmailTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Information',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 32,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Feel free to reach out for collaborations or just a '
          'friendly hello.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 17,
            height: 1.4,
          ),
        ),

        const SizedBox(height: 38),

        _ContactItem(
          icon: FontAwesomeIcons.phone,
          title: 'Phone',
          value: '+971 545706295',
          onTap: onPhoneTap,
        ),

        const SizedBox(height: 26),

        _ContactItem(
          icon: FontAwesomeIcons.envelope,
          title: 'Email',
          value: 'mohdsafu26@gmail.com',
          onTap: onEmailTap,
        ),

        const SizedBox(height: 26),

        const _ContactItem(
          icon: FontAwesomeIcons.locationDot,
          title: 'Location',
          value: 'Fujairah, UAE',
        ),
      ],
    );
  }
}

// ============================================================
// CONTACT ITEM
// ============================================================

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  final FaIconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,

      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              child: FaIcon(
                icon as FaIconData?,
                color: AppColors.primary,
                size: 24,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    value,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CONTACT FORM
// ============================================================

class _ContactForm extends StatelessWidget {
  const _ContactForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.messageController,
    required this.onSendMessage,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController messageController;

  final VoidCallback onSendMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _ContactTextField(controller: nameController, hintText: 'Your Name'),

          const SizedBox(height: 20),

          _ContactTextField(
            controller: emailController,
            hintText: 'Your Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }

              final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

              if (!emailRegex.hasMatch(value.trim())) {
                return 'Enter a valid email';
              }

              return null;
            },
          ),

          const SizedBox(height: 20),

          _ContactTextField(controller: subjectController, hintText: 'Subject'),

          const SizedBox(height: 20),

          _ContactTextField(
            controller: messageController,
            hintText: 'Your Message',
            maxLines: 6,
          ),

          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: ElevatedButton.icon(
                onPressed: onSendMessage,
                icon: const FaIcon(FontAwesomeIcons.paperPlane, size: 15),
                label: const Text(
                  'Send Message',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TEXT FIELD
// ============================================================

class _ContactTextField extends StatelessWidget {
  const _ContactTextField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
      cursorColor: AppColors.primary,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textSecondary.withValues(alpha: 0.65),
          fontSize: 16,
        ),
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.12),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }
}
