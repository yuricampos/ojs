<?php

/**
 * @file tests/data/60-content/DdioufSubmissionTest.php
 *
 * Copyright (c) 2014-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class DdioufSubmissionTest
 * @ingroup tests_data
 *
 * @brief Data build suite: Create submission
 */

import('tests.ContentBaseTestCase');

class DdioufSubmissionTest extends ContentBaseTestCase {
	/**
	 * Create a submission.
	 */
	function testSubmission() {
		$this->register(array(
			'username' => 'ddiouf',
			'firstName' => 'Diaga',
			'lastName' => 'Diouf',
			'affiliation' => 'Alexandria University',
			'country' => 'Egypt',
			'roles' => array('Author'),
		));

		$title = 'Genetic transformation of forest trees';
		$this->createSubmission(array(
			'title' => $title,
			'abstract' => 'In this review, the recent progress on genetic transformation of forest trees were discussed. Its described also, different applications of genetic engineering for improving forest trees or understanding the mechanisms governing genes expression in woody plants.',
		));

		$this->logOut();
		$this->findSubmissionAsEditor('dbarnes', null, $title);
		$this->assignParticipant('Section editor', 'David Buskins');
		$this->sendToReview();
		$this->waitForElementPresent('//a[contains(text(), \'Review\')]/*[contains(text(), \'Initiated\')]');
		$this->assignReviewer('phudson', 'Paul Hudson');
		$this->assignReviewer('agallego', 'Adela Gallego');
		$this->recordEditorialDecision('Accept Submission');
		$this->waitForElementPresent('//a[contains(text(), \'Editorial\')]/*[contains(text(), \'Initiated\')]');
		$this->assignParticipant('Copyeditor', 'Maria Fritz');
		$this->recordEditorialDecision('Send To Production');
		$this->waitForElementPresent('//a[contains(text(), \'Production\')]/*[contains(text(), \'Initiated\')]');
		$this->assignParticipant('Layout Editor', 'Graham Cox');
		$this->assignParticipant('Proofreader', 'Catherine Turner');
		$this->logOut();
	}
}
