--高速决斗技能-神鬼食人魔·骰子
Duel.LoadScript("speed_duel_common.lua")
function c100730311.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(31863912,c)
	aux.SpeedDuelBeforeDraw(c,c100730311.skill1)
	aux.SpeedDuelAtMainPhase(c,c100730311.skill,c100730311.con,aux.Stringid(100730171,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730311.skill1(e,tp)
   tp = e:GetLabelObject():GetOwner()
   local c=Duel.CreateToken(tp,15744417)
   Duel.SendtoDeck(c,tp,0,REASON_RULE)
   e:Reset()
end
function c100730311.Isfairy(c)
	return c:IsCode(81755371) and c:IsFaceup()
end

function c100730311.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730311.Isfairy,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c100730311.filter,tp,LOCATION_EXTRA,0,1,nil)
		and Duel.IsPlayerCanSpecialSummon(tp)
end
 
function c100730311.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730311)
	local g1=Duel.SelectMatchingCard(tp,c100730311.Isfairy,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local tc1=g1:GetFirst()
	local g2=Duel.SelectMatchingCard(tp,c100730311.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc2=g2:GetFirst()
	if tc2 then
		Duel.BreakEffect()
		tc2:SetMaterial(g1)
		Duel.Overlay(tc2,g1)
		Duel.SpecialSummon(tc2,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		tc2:CompleteProcedure()
	end
end
function c100730311.filter(c)
	return c:IsCode(42421606)
end