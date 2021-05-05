--高速决斗技能-绝望的拂晓
Duel.LoadScript("speed_duel_common.lua")
function c100730278.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730278.skill,c100730278.con,aux.Stringid(100730106,0))
	aux.SpeedDuelReplaceDraw(c,c100730278.skill1,c100730278.con1,aux.Stringid(100730185,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730278.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,nil,21251800)
end
function c100730278.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730278)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_HAND,0,1,1,nil,21251800)
	local tc=g:GetFirst()
	Duel.ConfirmCards(1-tp,tc)
	local sg=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if sg:GetCount()>0 then
		Duel.ChangePosition(sg,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
	Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,1,nil,28106077)
	if g1:GetCount()==0 then return end
	Duel.SendtoHand(g1,tp,REASON_RULE)
end
function c100730278.con1(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_DECK,0,nil,21251800)>0
		and Duel.GetTurnCount()>=5
end
function c100730278.skill1(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730278,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730278)
		local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK,0,nil,21251800)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
	end
end