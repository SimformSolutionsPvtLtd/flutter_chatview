import 'package:any_link_preview/any_link_preview.dart';
import 'package:chat_view/src/extensions/extensions.dart';
import 'package:chat_view/src/models/link_preview_configuration.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constants.dart';

class LinkPreview extends StatelessWidget {
  const LinkPreview({
    Key? key,
    required this.url,
    this.linkPreviewConfig,
  }) : super(key: key);
  final String url;
  final LinkPreviewConfiguration? linkPreviewConfig;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: linkPreviewConfig?.padding ??
          const EdgeInsets.symmetric(horizontal: 6, vertical: verticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: verticalPadding),
            child: url.isImageUrl
                ? InkWell(
                    onTap: _launchURL,
                    child: Image.network(
                      url,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : AnyLinkPreview(
                    link: url,
                    removeElevation: true,
                    placeholderWidget: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: linkPreviewConfig?.loadingColor,
                        ),
                      ),
                    ),
                    backgroundColor: linkPreviewConfig?.backgroundColor ??
                        Colors.grey.shade200,
                    borderRadius: linkPreviewConfig?.borderRadius,
                    bodyStyle: linkPreviewConfig?.bodyStyle ??
                        const TextStyle(color: Colors.black),
                    titleStyle: linkPreviewConfig?.titleStyle,
                  ),
          ),
          const SizedBox(height: verticalPadding),
          InkWell(
            onTap: _launchURL,
            child: Text(
              url,
              style: linkPreviewConfig?.linkStyle ??
                  const TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL() async =>
      await canLaunch(url) ? await launch(url) : throw couldNotLunch;
}
