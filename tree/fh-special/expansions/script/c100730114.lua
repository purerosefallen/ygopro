--高速决斗技能-蝼蚁和魔鬼
Duel.LoadScript("speed_duel_common.lua")
function c100730114.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730114.skill,c100730114.con,aux.Stringid(100730114,0))
	aux.SpeedDuelMoveCardToDeckCommon(39823987,c)
	aux.SpeedDuelMoveCardToDeckCommon(66818682,c)
	aux.SpeedDuelMoveCardToDeckCommon(41181774,c)
	aux.SpeedDuelMoveCardToDeckCommon(37910722,c)
	aux.SpeedDuelMoveCardToDeckCommon(25472513,c)
	aux.SpeedDuelMoveCardToDeckCommon(1686814,c)
	aux.SpeedDuelMoveCardToDeckCommon(60025883,c)
	aux.SpeedDuelMoveCardToDeckCommon(90884403,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730114.Issun(c)
	return c:IsCode(42280216) and c:IsFaceup()
end

function c100730114.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730114.Issun,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>0
end
function c100730114.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local op=Duel.SelectOption(tp,aux.Stringid(100730114,1),aux.Stringid(100730114,2))
	if op==0 then code=78275321 end
	if op==1 then code=78552773 end
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_HAND,0,1,1,nil,code)
	if g1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local nc=g1:GetFirst()
		Duel.SpecialSummon(nc,SUMMON_TYPE_SPECIAL,tp,tp,false,false,POS_FACEUP)
	end
end