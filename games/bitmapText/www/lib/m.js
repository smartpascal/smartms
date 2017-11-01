if (typeof smartms === "undefined") {
    smartms = {};
}

smartms.dialogs = (function (params) {

var app = this;

	// Default Parameters
	app.params = {
		modalTemplate: '<div class="modal {{noButtons}}">' +
							'<div class="modal-inner">' +
								'{{if title}}<div class="modal-title">{{title}}</div>{{/if title}}' +
								'<div class="modal-text">{{text}}</div>' +
								'{{afterText}}' +
							'</div>' +
							'<div class="modal-buttons">{{buttons}}</div>' +
						'</div>',
		modalActionsTemplate: '<div class="actions-modal">{{buttons}}</div>',
		modalButtonOk: 'OK',
		modalButtonCancel: 'Cancel',
		modalTitle: 'SmartMS',
		modalCloseByOutside: false,
		modalActionsCloseByOutside: true,
		modalPreloaderText: 'Loading... ',
		modalPreloaderTitle: 'Loading... ',
		modalUsernamePlaceholder: 'Username',
		modalPasswordPlaceholder: 'Password',
		popupCloseByOutside: true,
		popoverCloseByOutside: true,
		modalStack: true,
		modalsMoveToRoot: true,
		material: false,
		materialPreloaderSvg: '<svg xmlns="http://www.w3.org/2000/svg" height="75" width="75" viewbox="0 0 75 75"><circle cx="37.5" cy="37.5" r="33.5" stroke-width="8"/></svg>',
		materialPreloaderHtml:
			'<span class="preloader-inner">' +
				'<span class="preloader-inner-gap"></span>' +
				'<span class="preloader-inner-left">' +
					'<span class="preloader-inner-half-circle"></span>' +
				'</span>' +
				'<span class="preloader-inner-right">' +
					'<span class="preloader-inner-half-circle"></span>' +
				'</span>' +
			'</span>'
		
		
	};

	// Extend defaults with parameters
	for (var param in params) {
		app.params[param] = params[param];
	}
	
/*======================================================
************   Modals   ************
======================================================*/
app._modalTemlateTempDiv = document.createElement('div');
app.modal = function (params) {
    params = params || {};
    /* @params example
    {
        title: 'Modal title',
        text: 'Modal text',
        afterText: 'Custom content after text',
        buttons: [{
            text:'Cancel',
            bold: true,
            onClick: function(){},
            close:false
        }]
    }
    */
    var buttonsHTML = '';
    if (params.buttons && params.buttons.length > 0) {
        for (var i = 0; i < params.buttons.length; i++) {
            buttonsHTML += '<span class="modal-button' + (params.buttons[i].bold ? ' modal-button-bold' : '') + '">' + params.buttons[i].text + '</span>';
        }
    }
    var modalTemplate = app.params.modalTemplate;
    if (!params.title) {
        modalTemplate = modalTemplate.split('{{if title}}')[0] + modalTemplate.split('{{/if title}}')[1];
    }
    else {
        modalTemplate = modalTemplate.replace(/{{if\ title}}/g, '').replace(/{{\/if\ title}}/g, '');
    }
    var modalHTML = modalTemplate
                    .replace(/{{title}}/g, params.title || '')
                    .replace(/{{text}}/g, params.text || '')
                    .replace(/{{afterText}}/g, params.afterText || '')
                    .replace(/{{buttons}}/g, buttonsHTML)
                    .replace(/{{noButtons}}/g, !params.buttons || params.buttons.length === 0 ? 'modal-no-buttons' : '');
    app._modalTemlateTempDiv.innerHTML = modalHTML;

    var modal = smartms(app._modalTemlateTempDiv).children();

    smartms('body').append(modal[0]);
    
    // Add events on buttons
    modal.find('.modal-button').each(function (index, el) {
        smartms(el).on('click', function (e) {
            if (params.buttons[index].close !== false) app.closeModal(modal);
            if (params.buttons[index].onClick) params.buttons[index].onClick(modal, e);
        });
    });
    app.openModal(modal);
    return modal[0];
};
/*app.alert = function (text, title) {
    return app.modal({
        text: text || '',
        title: title || app.params.modalTitle,
        buttons: [ {text: app.params.modalButtonOk, bold: true} ]
    });
};*/
app.alert = function (text, title, callbackOk) {
    if (typeof title === 'function') {
        callbackOk = arguments[1];
        title = undefined;
    }
    return app.modal({
        text: text || '',
        title: typeof title === 'undefined' ? app.params.modalTitle : title,
        buttons: [ {text: app.params.modalButtonOk, bold: true, onClick: callbackOk} ]
    });
};
/*
app.confirm = function(text, callbackOk, callbackCancel) {
    return app.modal({
        text: text || '',
        title: app.params.modalTitle || '',
        buttons: [
            {text: app.params.modalButtonCancel, onClick: callbackCancel},
            {text: app.params.modalButtonOk, bold: true, onClick: callbackOk}
        ]
    });
};*/
app.confirm = function (text, title, callbackOk, callbackCancel) {
    if (typeof title === 'function') {
        callbackCancel = arguments[2];
        callbackOk = arguments[1];
        title = undefined;
    }
    return app.modal({
        text: text || '',
        title: typeof title === 'undefined' ? app.params.modalTitle : title,
        buttons: [
            {text: app.params.modalButtonCancel, onClick: callbackCancel},
            {text: app.params.modalButtonOk, bold: true, onClick: callbackOk}
        ]
    });
};

app.prompt = function (text, title, callbackOk, callbackCancel) {
if (typeof title === 'function') {
	callbackCancel = arguments[2];
	callbackOk = arguments[1];
	title = undefined;
}
    return app.modal({
        text: text || '',
        //title: app.params.modalTitle || '',
		title: typeof title === 'undefined' ? app.params.modalTitle : title,
        afterText: '<input type="text" class="modal-prompt-input">',
        buttons: [
            {text: app.params.modalButtonCancel, onClick: function(modal){
                if (callbackCancel) callbackCancel(smartms(modal).find('.modal-prompt-input').val());
            }},
            {text: app.params.modalButtonOk, bold:true, onClick: function(modal){
                if (callbackOk) callbackOk(smartms(modal).find('.modal-prompt-input').val());
            }}
        ]
    });
};
/*
app.prompt = function (text, title, callbackOk, callbackCancel) {
    if (typeof title === 'function') {
        callbackCancel = arguments[2];
        callbackOk = arguments[1];
        title = undefined;
    }
    return app.modal({
        text: text || '',
        title: typeof title === 'undefined' ? app.params.modalTitle : title,
        afterText: '<div class="input-field"><input type="text" class="modal-text-input"></div>',
        buttons: [
            {
                text: app.params.modalButtonCancel
            },
            {
                text: app.params.modalButtonOk,
                bold: true
            }
        ],
        onClick: function (modal, index) {
            if (index === 0 && callbackCancel) callbackCancel(smartms(modal).find('.modal-text-input').val());
            if (index === 1 && callbackOk) callbackOk(smartms(modal).find('.modal-text-input').val());
        }
    });
};
*/
app.modalLogin = function (text, title, callbackOk, callbackCancel) {
    if (typeof title === 'function') {
        callbackCancel = arguments[2];
        callbackOk = arguments[1];
        title = undefined;
    }
    return app.modal({
        text: text || '',
        title: typeof title === 'undefined' ? app.params.modalTitle : title,
        afterText: '<div class="input-field modal-input-double"><input type="text" name="modal-username" placeholder="' + app.params.modalUsernamePlaceholder + '" class="modal-text-input"></div><div class="input-field modal-input-double"><input type="password" name="modal-password" placeholder="' + app.params.modalPasswordPlaceholder + '" class="modal-text-input"></div>',
        buttons: [
            {
                text: app.params.modalButtonCancel, 
				onClick: function(modal){
                  if (callbackCancel) callbackCancel(smartms(modal).find('.modal-text-input[name="modal-username"]').val(), smartms(modal).find('.modal-text-input[name="modal-password"]').val());
				}
            },
            {
                text: app.params.modalButtonOk,
                bold: true, 
				onClick: function(modal){
                  if (callbackOk) callbackOk(smartms(modal).find('.modal-text-input[name="modal-username"]').val(), smartms(modal).find('.modal-text-input[name="modal-password"]').val());
				}
            }
        ]/*,
        onClick: function (modal, index) {
            var username = smartms(modal).find('.modal-text-input[name="modal-username"]').val();
            var password = smartms(modal).find('.modal-text-input[name="modal-password"]').val();
            if (index === 0 && callbackCancel) callbackCancel(username, password);
            if (index === 1 && callbackOk) callbackOk(username, password);
        }*/
    });
};
app.modalPassword = function (text, title, callbackOk, callbackCancel) {
    if (typeof title === 'function') {
        callbackCancel = arguments[2];
        callbackOk = arguments[1];
        title = undefined;
    }
    return app.modal({
        text: text || '',
        title: typeof title === 'undefined' ? app.params.modalTitle : title,
        afterText: '<div class="input-field"><input type="password" name="modal-password" placeholder="' + app.params.modalPasswordPlaceholder + '" class="modal-text-input"></div>',
        buttons: [
            {
                text: app.params.modalButtonCancel,
				onClick: function(modal){
                  if (callbackCancel) callbackCancel(smartms(modal).find('.modal-text-input[name="modal-password"]').val());
				}
            },
            {
                text: app.params.modalButtonOk,
                bold: true,
				onClick: function(modal){
                  if (callbackOk) callbackOk(smartms(modal).find('.modal-text-input[name="modal-password"]').val());
				}				
            }
        ]/*,
        onClick: function (modal, index) {
            var password = smartms(modal).find('.modal-text-input[name="modal-password"]').val();
            if (index === 0 && callbackCancel) callbackCancel(password);
            if (index === 1 && callbackOk) callbackOk(password);
        }*/
    });
};
/*app.showPreloader = function (text) {
    return app.modal({
        title: text || app.params.modalPreloaderText,
        text:' ',
        afterText: '<div class="preloader"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></div>'
    });
};*/
app.showPreloader = function (title) {
    return app.modal({
        title: title || app.params.modalPreloaderTitle,
        text: '<div class="preloader">' + (app.params.material ? app.params.materialPreloaderHtml : '') + '</div>',
        cssClass: 'modal-preloader'
    });
};
app.hidePreloader = function () {
    app.closeModal();
    //app.closeModal('.modal-preloader');
};

app.showIndicator = function () {
  smartms('body').append('<div class="preloader-indicator-overlay"></div><div class="preloader-indicator-modal"><span class="preloader preloader-white"></span></div>');
  //if (smartms('.preloader-indicator-overlay').length > 0) return;
  //app.root.append('<div class="preloader-indicator-overlay"></div><div class="preloader-indicator-modal"><span class="preloader preloader-white">' + (app.params.material ? app.params.materialPreloaderHtml : '') + '</span></div>');
};

app.hideIndicator = function () {
  smartms('.preloader-indicator-overlay, .preloader-indicator-modal').remove();
};

// Action Sheet
app.actions = function(params) {
    params = params || [];
    /*Example of @params
    [
        [
            {
                text: 'Button 1',
                red: false,
                bold: false,
                onClick: function() { ... }
            },
            {
                text: '<a href="#" class="open-panel">Open panel</a>',
                red: false,
                bold: false,
                onClick: function() { ... }  
            }
            ... more buttons in this group
        ],
        ... more groups
    ]
    */
    if (params.length > 0 && !smartms.isArray(params[0])) {
        params = [params];
    }

    var actionsTemplate = app.params.modalActionsTemplate;
    var buttonsHTML = '';
    for (var i = 0; i < params.length; i++) {
        for (var j = 0; j < params[i].length; j++) {
            if (j === 0) buttonsHTML += '<div class="actions-modal-group">';
            var button = params[i][j];
            var buttonClass = 'actions-modal-button';
            if (button.bold) buttonClass += ' actions-modal-button-bold';
            if (button.red) buttonClass += ' actions-modal-button-red';
            buttonsHTML += '<span class="' + buttonClass + '">' + button.text + '</span>';
            if (j === params[i].length - 1) buttonsHTML += '</div>';
        }
    }
    var modalHTML = actionsTemplate.replace(/{{buttons}}/g, buttonsHTML);

    app._modalTemlateTempDiv.innerHTML = modalHTML;
    var modal = smartms(app._modalTemlateTempDiv).children();
    smartms('body').append(modal[0]);

    var groups = modal.find('.actions-modal-group');
    groups.each(function (index, el) {
        var groupIndex = index;
        smartms(el).find('.actions-modal-button').each(function (index, el) {
            var buttonIndex = index;
            var buttonParams = params[groupIndex][buttonIndex];
            smartms(el).on('click', function (e) {
                if (buttonParams.close !== false) app.closeModal(modal);
                if (buttonParams.onClick) buttonParams.onClick(modal, e);
            })
        });
    });
    app.openModal(modal);
    return modal[0];
};
app.openModal = function (modal) {
    modal = smartms(modal);
    if (smartms('.modal-overlay').length === 0) {
        var overlay = document.createElement('div');
        overlay.className = 'modal-overlay';
        smartms('body').append(overlay);
    }
    if (!modal.hasClass('actions-modal')) modal.css({marginTop: -modal.outerHeight() / 2 + 'px'});
    //Make sure that styles are applied, trigger relayout;
    var clientLeft = modal[0].clientLeft;

    // Classes for transition in
    smartms('.modal-overlay').addClass('modal-overlay-visible');
    smartms(modal).addClass('modal-in');
    return true;
};
app.closeModal = function (modal) {
    modal = smartms(modal || '.modal-in');
    smartms('.modal-overlay').removeClass('modal-overlay-visible');
    modal.trigger('close');
    modal.toggleClass('modal-in modal-out').transitionEnd(function (e) {
        modal.trigger('closed');
        modal.remove();
    });
    return true;
};

});