--高速决斗技能-命运占卜
Duel.LoadScript("speed_duel_common.lua")
function c100730241.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730241.skill,c100730241.con,aux.Stringid(100730241,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730241.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730241.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)~=0
end
function c100730241.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x31)
end
function c100730241.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730241)
	local g1=Duel.SelectMatchingCard(tp,c100730241.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local c=g1:GetFirst()
	if not c then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if not tc then return end
	if tc:IsType(TYPE_MONSTER) then
		Duel.DisableShuffleCheck()
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(tc:GetLevel())
		c:RegisterEffect(e1)
		Duel.ShuffleHand(tp)
	else
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(tc,tp,REASON_RULE)
		Duel.ShuffleHand(tp)
	end
end
