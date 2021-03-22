--高速决斗技能-设定！三角加速！
Duel.LoadScript("speed_duel_common.lua")
function c100730156.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730156.skill,c100730156.con,aux.Stringid(100730156,0))
	aux.SpeedDuelMoveCardToDeckCommon(51447164,c)
	aux.SpeedDuelMoveCardToDeckCommon(62560742,c)
	aux.SpeedDuelMoveCardToDeckCommon(99937842,c)
	aux.SpeedDuelMoveCardToDeckCommon(98558751,c)
	aux.SpeedDuelMoveCardToDeckCommon(97836203,c)
	aux.SpeedDuelMoveCardToDeckCommon(50750868,c)
	aux.SpeedDuelMoveCardToDeckCommon(63180841,c)
	aux.SpeedDuelMoveCardToDeckCommon(90953320,c)
	aux.SpeedDuelMoveCardToDeckCommon(24943456,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730156.IsTG(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsFaceup() and c:IsSetCard(0x27)
end

function c100730156.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730156.IsTG,tp,LOCATION_MZONE,0,2,nil)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,62560742)
end
function c100730156.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730156)
	local g=Duel.GetMatchingGroup(c100730156.IsTG,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
		local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_EXTRA,0,1,1,nil,62560742)
		if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:GetFirst()
		if tc then
			Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		end
	end 
end